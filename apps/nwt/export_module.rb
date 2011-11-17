require 'fileutils'

module ExportModule

  attr_accessor :export_soupname
  attr_accessor :export_dir
  
  def export_usage
    return <<EOT
  Export soup:
    --export, -e <Soup Name>
      Export a Newton soup and saves the content to a subfolder
      with the soup name.

EOT
  end

  def export_get_opts
    return [
      ["--export", "-e", GetoptLong::REQUIRED_ARGUMENT],
      ["--export-dir", GetoptLong::REQUIRED_ARGUMENT]
    ]
  end
  
  def export_handle_opts(opt, arg)
    case opt
    when "--export" then @cmd = "export"; @arg = arg; @export_soupname = String.new(arg)
    when "--export-dir" then @export_dir = String.new(arg)
    end
  end

  def export_transition(state, action)
    case [state, action.command]
    when [:idle, AppCmd::CONNECTED] then
      @dock.receive(AppCmd.new(AppCmd::GET_STORE_NAMES))
      state = :export
      @export_dir = @export_soupname if not @export_dir
      FileUtils.remove_dir(@export_dir) if File.exist?(@export_dir)
      Dir.mkdir(@export_dir)
    when [:export, AppCmd::STORE_NAMES] then
      @newton_stores = action.data.to_ruby
      @current_store = 0
      @dock.receive(AppCmd.new(AppCmd::SET_CURRENT_STORE, @newton_stores[@current_store]))
    when [:export, AppCmd::STORE_SELECTED] then
      puts "Reading from store: #{@newton_stores[@current_store][:name]}"
      @dock.receive(AppCmd.new(AppCmd::SET_CURRENT_SOUP, @export_soupname))
    when [:export, AppCmd::SOUP_SELECTED] then
      if action.data == 0
        @dock.receive(AppCmd.new(AppCmd::SEND_SOUP))
      else
        state = export_next_store
      end
    when [:export, AppCmd::CURSOR_ENTRY] then
      export_handle_entry(action.data)
    when [:export, AppCmd::SOUP_SENT] then
      state = export_next_store
    end
    return state
  end
  
  def export_next_store
    @current_store += 1
    if @current_store < @newton_stores.length
      @dock.receive(AppCmd.new(AppCmd::SET_CURRENT_STORE, @newton_stores[@current_store]))
      state = :export
    else
      @dock.receive(AppCmd.new(AppCmd::DISCONNECT))
      state = :idle
    end
  end
  
  def export_handle_entry(data)
    e = data[:translated].to_ruby

    log "Entry:\n#{e.to_yaml}" if @flags[:verbose]
    if e[:title]
      puts "#{e[:title]}"
    elsif e[:name]
      puts "#{e[:name]}"
    else
      puts "ID: #{e[:_uniqueID]}"
    end
      
    if e[:_uniqueID].class != Fixnum
      File.open("entry.nsof", "wb+") { |f| f.write(data[:nsof]) }
    end
    basename = @export_dir + '/' +
      @newton_stores[@current_store][:signature].to_s +
      "-" + e[:_uniqueID].to_s 

    File.open(basename + ".nsof", "wb") do |f|
      f.write(data[:nsof])
    end
  end
  
end
