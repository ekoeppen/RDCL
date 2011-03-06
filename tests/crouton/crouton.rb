#!/usr/bin/env ruby

$LOAD_PATH << File.join(File.dirname(__FILE__), "../../../")

require "yaml"
require "wx"

require "rdcl/link/serial_dock_link.rb"
require "rdcl/link/app_cmds/app_cmd_disconnect.rb"
require "rdcl/link/app_cmds/app_cmd_get_app_list.rb"
require "rdcl/apps/crouton/framework/sidebar_icon.rb"
require "rdcl/apps/crouton/framework/plugin_container.rb"
require "rdcl/apps/crouton/plugins/info/info_plugin.rb"
require "rdcl/apps/crouton/plugins/packages/packages_plugin.rb"

require "controller"
require "model"

module RDCL
  
  class Crouton < Wx::App  # a new class which derives from the Wx::App class

    attr_accessor :dock
    attr_accessor :controller
    attr_accessor :model
    attr_accessor :settings
    attr_accessor :status_bar

    def initialize 
      super

      @settings = YAML::load(File.new(Platform.settings_file))
      @model = Model.new(self)

      @controller = Controller.new(self)
      @controller.run

      @dock = SerialDockLink.new(settings)
      @dock.application = @controller
      @dock.run
    end

    def on_init
      if not RUBY_VERSION =~ /1.9/
        t = Wx::Timer.new(self, 55)
        evt_timer(55) { Thread.pass }
        t.start(5)
      end
    
      frame = Wx::Frame.new(nil, -1, 'Crouton')
      frame.set_client_size(Wx::Size.new(400,200))
      frame.set_background_colour(Wx::WHITE)
    
      plugin_list = PluginContainer.new

      sizer = Wx::BoxSizer.new(Wx::HORIZONTAL)
      workarea = Wx::Window.new(frame, -1)
      workarea.evt_size do |event|
        plugin_list.on_size(event)
      end

      plugin_list.add_plugin(InfoPlugin.new(frame, workarea, 10, self))
      plugin_list.add_plugin(PackagesPlugin.new(frame, workarea, 20, self))

      sizer.add(plugin_list.sizer, 0, Wx::ALIGN_RIGHT, 2)
      sizer.add(workarea, 1, Wx::GROW|Wx::ALL, 2)

      workarea.show()
      frame.set_sizer(sizer)
      @status_bar = frame.create_status_bar(1)
      frame.set_status_text("Idle")
      frame.show()
    end
  
  end
  
end

Thread.abort_on_exception = true

n = RDCL::Crouton.new
n.main_loop

