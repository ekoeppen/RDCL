require "rdcl/link/dock_cmds/dock_cmd.rb"

module RDCL

  class DockCmdGetStoreNames < DockCmd

    def initialize
      @command = DockCmd::GET_STORE_NAMES
    end
    
  end

end
