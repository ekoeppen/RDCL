require "rdcl/link/dock_modules/dock_module.rb"
require "rdcl/link/app_cmds/app_cmd.rb"

module RDCL

  class KbdDockModule < DockModule
    
    def initialize(dock_link)
      super(dock_link, :kbd_dock_module)
      
      @log_transitions = nil

      init_automaton :idle, [:idle]
      transition do |state, action|
        new_state = case [state, action]
        when [:idle, DockCmd::START_KEYBOARD_PASSTHROUGH] then start_kbd_passthrough; :kbd_passthrough
        when [:kbd_passthrough, DockCmd::OPERATION_CANCELED2] then ack_cancel; :idle
        when [:kbd_passthrough, DockCmd::OPERATION_CANCELED] then ack_cancel; :idle
        else nil
        end

        new_state = state if not new_state
        new_state
      end
    end

    def start_kbd_passthrough
      app_receive(AppCmd.new(AppCmd::START_KEYBOARD_PASSTHROUGH))
    end

    def ack_cancel
      dock_write(DockCmdOpCanceledAck.new)
    end

  end
  
end