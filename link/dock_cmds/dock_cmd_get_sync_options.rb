require "rdcl/link/dock_cmds/dock_cmd.rb"

module RDCL

  class DockCmdGetSyncOptions < DockCmd

    def initialize
      @command = DockCmd::GET_SYNC_OPTIONS
    end
    
    def to_binary
      return "newtdock" + @command + [0].pack("N")
    end

  end

end
