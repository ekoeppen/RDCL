require "rdcl/link/dock_modules/dock_module.rb"
require "rdcl/link/app_cmds/app_cmd_app_list.rb"

module RDCL

  class AppListDockModule < DockModule
    
    def initialize(dock_link)
      super(dock_link, :app_list_dock_module)
      
      @log_transitions = nil

      init_automaton :idle, [:idle]
      transition do |s, a|
        new_state = case [s, a]
        when [:idle, AppCmd::GET_APP_LIST] then start_get_app_list; :get_app_list
        when [:get_app_list, DockCmd::APP_NAMES] then finish_get_app_list; :idle
        when [:get_app_list, DockCmd::OPERATION_CANCELED2] then ack_cancel; :idle
        else nil
        end

        new_state = s if not new_state
        new_state
      end
    end

    def start_get_app_list
      dock_write(DockCmdGetAppNames.new(DockCmdGetAppNames::ALL_STORES_NAMES_SOUPS))
    end

    def finish_get_app_list
      dock_write(DockCmdOperationDone.new)

      @command.data.slice!(0)
      obj = NSObjectFactory.new.from_nsof_factory(@command.data)

      app_receive(AppCmdAppList.new(obj))
    end

    def ack_cancel
      dock_write(DockCmdOpCanceledAck.new)
    end

  end
  
end