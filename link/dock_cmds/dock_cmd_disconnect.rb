require "rdcl/link/dock_cmds/dock_cmd.rb"

module RDCL

  class DockCmdDisconnect < DockCmd
  
    def initialize
      @command = DockCmd::DISCONNECT
    end
  
  end

end
