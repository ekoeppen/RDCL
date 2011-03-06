require "rdcl/link/dock_cmds/dock_cmd.rb"

module RDCL

  class DockCmdInitiateDocking < DockCmd
    
    SESSION_NONE            = 0
    SESSION_SETTING_UP      = 1
    SESSION_SYNCHRONIZE     = 2
    SESSION_RESTORE         = 3
    SESSION_LOAD_PACKAGE    = 4
    SESSION_TEST_COMM       = 5
    SESSION_LOAD_PATCH      = 6
    SESSION_UPDATING_STORES = 7

    attr_accessor :session_type
    
    def initialize(session_type)
      @command = DockCmd::INITIATE_DOCKING
      @session_type = session_type
    end
    
    def to_binary
      return "newtdock" + @command + [4, @session_type].pack("NN")
    end
    
  end

end
