require "rdcl/link/dock_cmds/dock_cmd.rb"

module RDCL

  class DockCmdGetDefaultStore < DockCmd

    def initialize
      @command = DockCmd::GET_DEFAULT_STORE
    end
    
  end

end
