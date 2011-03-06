require "rdcl/link/dock_cmds/dock_cmd.rb"

module RDCL

  class DockCmdOperationCanceled < DockCmd

    def initialize
      @command = DockCmd::OPERATION_CANCELED
    end
    
    def to_binary
      return "newtdock" + @command + [0].pack("N")
    end

  end

end
