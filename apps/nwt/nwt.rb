#!/usr/bin/env ruby

$LOAD_PATH.insert(0, "../../../")

require "async"
require "rdcl/link/serial_dock_link.rb"
require "rdcl/link/app_cmds/app_cmd_install_package.rb"
require "rdcl/link/dock_cmds/dock_cmd_factory.rb"
require "rdcl/utils/des.rb"
require "rdcl/apps/nwt/install_module.rb"
require "rdcl/apps/nwt/info_module.rb"
require "rdcl/apps/nwt/query_module.rb"
require "rdcl/apps/nwt/io_module.rb"
require "rdcl/apps/nwt/export_module.rb"
require "rdcl/VERSION.rb"
require "yaml"
require "getoptlong"

include RDCL

Thread.abort_on_exception = true

class NWT < Actor
  
  attr_accessor :settings
  attr_accessor :dock
  attr_accessor :opts
  attr_accessor :opts_array
  attr_accessor :cmd
  attr_accessor :flags
  attr_accessor :newton_stores
  attr_accessor :current_store
  attr_accessor :cursor
  attr_accessor :cmd_line_settings
  attr_accessor :user_modules

  include InstallModule
  include InfoModule
  include QueryModule
  include IoModule
  include ExportModule
  
  def load_user_modules
    @user_modules = Array.new
    if Dir.exist?(ENV["HOME"] + "/.nwt")
      Dir[ENV["HOME"] + "/.nwt/*_module.rb"].each do |f|
        full_name = File.basename(f).gsub(/(^|_)(.)/) { $2.upcase }[0..-4] 
        short_name = File.basename(f).gsub("_module.rb", "")
        @user_modules << short_name
        load f
        extend Object.const_get(full_name)
        @opts_array += send((short_name + "_get_opts").intern)
      end
    end
  end

  def initialize
    super()
    @stat = :idle
    @flags = {}
    @cmd_line_settings = {}
    
    @opts_array = [
      ["--help", "-h", GetoptLong::NO_ARGUMENT],
      ["--verbose", "-v", GetoptLong::NO_ARGUMENT],
      ["--quiet", "-q", GetoptLong::NO_ARGUMENT],
      ["--test", "-t", GetoptLong::NO_ARGUMENT],
      ["--log", GetoptLong::NO_ARGUMENT],
      ["--speed", GetoptLong::REQUIRED_ARGUMENT],
      ["--port", GetoptLong::REQUIRED_ARGUMENT],
      ["--version", "-V", GetoptLong::NO_ARGUMENT],
      ["--write-settings", GetoptLong::OPTIONAL_ARGUMENT],
      ["--show-settings", GetoptLong::NO_ARGUMENT],
      ["--convert", "-c", GetoptLong::NO_ARGUMENT]
    ]

    @opts_array += io_get_opts + info_get_opts + install_get_opts + export_get_opts

    load_user_modules
    
    @opts = GetoptLong.new(*@opts_array)
    
    transition do |state, action|
      log_action(state, action)
      case action.command
      when AppCmd::CONNECTED then
        sleep(1)
        log "Connected."
      when AppCmd::DISCONNECTED then
        log "Disconnected."
        exit
      end
      state = send("#{@cmd}_transition", state, action)
      state
    end
  end
  
  def initialize_modules
    io_initialize
  end
  
  def read_settings
    @settings = Platform.check_settings
    exit 1 if not @settings
    @cmd_line_settings.each do |i, v|
      @settings[i] = v
    end
  end
  
  def show_settings
    read_settings
    @settings.each { |i, v| puts "#{i}: #{v}\n" }
  end
  
  def write_settings
    s = ""
    if @arg == ""
      puts "Please enter the new settings, followed by CTRL-D or CTRL-Z:"
      while line = gets
        s += line
      end
    else
      File.open(@arg) { |f| s = f.read }
    end
    Platform.write_settings(s)
  end
  
  def show_version
    puts "nwt/RDCL version #{RDCL_VERSION}"
  end
  
  def show_help
    h = <<EOT

nwt: Package management, data synchronization and export for the Newton

USAGE

  nwt <options> ...

GENERAL OPTIONS

  The following options apply to all operations:
  
  --log
    Prints debug information
  
  --verbose
    Prints more detailed progress and status information
  
  --quiet
    Suppresses most output
  
  --speed <speed>
    Sets the serial speed (setting file: "serial_speed")
  
  --port <port>
    Sets the serial port (setting file: "serial_port")
    
  --write-settings
    Prompts for settings and writes them to the settings file
    
  --show-settings
    Displays current settings

  --convert, -c
    Automatically convert sent and received data.

SETTINGS

  Settings are stored in a settings file, but can be overridden via command
  line arguments. The settings file format is YAML.
  
EOT
    h += "  Current settings are stored in #{Platform.settings_file}\n"
    h += "\nOPERATIONS\n\n"
    h += info_usage + install_usage + io_usage + export_usage
    @user_modules.each do |m|
      h += send((m + "_usage").intern)
    end
    puts h
  end
  
  def test_transition(state, action)
    return state
  end
  
  def log_action(state, action)
    if @flags[:verbose] then puts "<<<\n" + action.to_yaml end
  end
    
  def log(string)
    if not @flags[:quiet] then puts(string) end
  end
  
  def parse_opts
    continue = true
    @cmd = nil
    @opts.each do |opt, arg|
      # query_handle_opts(opt, arg)
      install_handle_opts(opt, arg)
      info_handle_opts(opt, arg)
      io_handle_opts(opt, arg)
      export_handle_opts(opt, arg)
      @user_modules.each do |m|
        send((m + "_handle_opts").intern, opt, arg)
      end

      case opt
      when "--help" then @cmd = "help"; show_help; continue = nil
      when "--version" then @cmd = "version"; show_version; continue = nil
      when "--write-settings" then @cmd = "settings"; @arg = arg; write_settings; continue = nil
      when "--show-settings" then @cmd = "show_settings"; show_settings; continue = nil
      when "--verbose" then @flags[:verbose] = true
      when "--quiet" then @flags[:quiet] = true
      when "--log" then @flags[:log] = true
      when "--speed" then @cmd_line_settings["serial_speed"] = arg.to_i
      when "--port" then @cmd_line_settings["serial_port"] = String.new(arg)
      when "--test" then @cmd = "test"; @arg = String.new(arg);
      when "--convert" then @flags[:convert] = true
      end
    end
    if not @cmd
      show_help
      continue = false
    end
    return continue
  end

  def setup_dock
    @dock = SerialDockLink.new(@settings, @flags[:log])
    @dock.application = self
  end

  def start
    if @flags[:verbose]
      puts "Settings:"
      puts @settings.to_yaml
    end
    log "Waiting for connection on #{@settings['serial_port']}..."

    Async do |task|
      task.async do
        run
      end

      task.async do
        @dock.connect
      end

      task.async do
        @dock.run
      end
    end
  end
  
  def show_stores
    log "Stores:"
    @newton_stores.each do |store|
      log "Name: #{store.name}, size: #{store.size / 1024}k, free: #{(store.totalsize - store.usedsize) / 1024}k"
    end
  end
  
end

app = NWT.new
if app.parse_opts
  app.read_settings
  app.initialize_modules
  app.setup_dock
  app.start
end
