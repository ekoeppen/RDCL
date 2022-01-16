require "rdcl/communication/dock_layer.rb"
require "rdcl/utils/actor.rb"
require "rdcl/link/dock_modules/connect_dock_module.rb"
require "rdcl/link/dock_modules/kbd_dock_module.rb"
require "rdcl/link/dock_modules/browse_desktop_dock_module.rb"
require "rdcl/link/dock_modules/app_list_dock_module.rb"
require "rdcl/link/dock_modules/install_package_dock_module.rb"
require "rdcl/link/dock_modules/storage_dock_module.rb"

module RDCL

  class DockLink < Actor
    
    attr_accessor :dock_layer
    attr_accessor :application
    attr_accessor :dock_modules
    attr_accessor :command

    def initialize(timeout = nil)
      super()
      
      @dock_layer = DockLayer.new
      @dock_layer.link = self
      @application = Object.new
      @dock_modules = []

      def @application.receive(message)
        puts "<<<\n" + message.to_s
      end
      
      init_automaton :idle, [:idle]
      transition do |state, action|
        @dock_modules.each do |m|
          m.process_message(action)
        end
        state
      end
      
      ConnectDockModule.new(self)
      KbdDockModule.new(self)
      BrowseDesktopDockModule.new(self)
      AppListDockModule.new(self)
      InstallPackageDockModule.new(self)
      StorageDockModule.new(self)
    end

    def process_message(b)
      @command = b
      automaton_input(b)
    end

  end
  
end
