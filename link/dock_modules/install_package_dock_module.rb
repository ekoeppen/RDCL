require "rdcl/link/dock_modules/dock_module.rb"

module RDCL

  class InstallPackageDockModule < DockModule

    attr_accessor :package_data
    
    def initialize(dock_link)
      super(dock_link, :install_package_dock_module)
      
      @log_transitions = nil

      init_automaton :idle, [:idle]
      transition do |s, a|
        new_state = case [s, a]
        when [:idle, AppCmd::INSTALL_PACKAGE] then start_install_package; :install_package
        when [:install_package, DockCmd::RESULT] then send_package; :package_sent
        when [:package_sent, DockCmd::RESULT] then install_complete; :idle

        when [:install_package, DockCmd::OPERATION_CANCELED2] then ack_cancel; :idle
        when [:package_sent, DockCmd::OPERATION_CANCELED2] then ack_cancel; :idle
        else nil
        end

        new_state = s if not new_state
        new_state
      end
    end

    def start_install_package
      @package_data = @command.data
      dock_write(DockCmdRequestToInstall.new)
    end

    def send_package
      puts "Sending package data..."
      dock_write(DockCmdLoadPackage.new(@package_data))
    end

    def install_complete
      puts "Package installed."
      app_receive(AppCmd.new(AppCmd::PACKAGE_INSTALLED))
    end

    def ack_cancel
      dock_write(DockCmdOpCanceledAck.new)
    end
    
  end
  
end