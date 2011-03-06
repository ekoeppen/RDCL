require "rdcl/link/dock_cmds/dock_cmd.rb"

module RDCL

  class DockCmdOpCanceledAck < DockCmd
    
    def initialize
      @command = DockCmd::OP_CANCELED_ACK
    end
    
  end

end
