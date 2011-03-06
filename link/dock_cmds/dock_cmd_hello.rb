require "rdcl/link/dock_cmds/dock_cmd.rb"

module RDCL

  class DockCmdHello < DockCmd

    def initialize
      @command = DockCmd::HELLO
    end
    
    def to_binary
      return "newtdock" + @command + [0].pack("N")
    end
    
  end

end
