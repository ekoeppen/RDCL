require "rdcl/link/dock_cmds/dock_cmd.rb"

module RDCL

  class DockCmdGetInternalStore < DockCmd

    def initialize
      @command = DockCmd::GET_INTERNAL_STORE
      @data = nil
    end
    
  end

end
