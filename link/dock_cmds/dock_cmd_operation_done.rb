require "rdcl/link/dock_cmds/dock_cmd.rb"

module RDCL

  class DockCmdOperationDone < DockCmd
  
    def initialize
      @command = DockCmd::OPERATION_DONE
    end
  
  end

end
