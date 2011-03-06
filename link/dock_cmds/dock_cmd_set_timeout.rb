require "rdcl/link/dock_cmds/dock_cmd.rb"

module RDCL

  class DockCmdSetTimeout < DockCmd

    attr_accessor :timeout
    
    def initialize
      @command = DockCmd::SET_TIMEOUT
      @timeout = 300
    end
    
    def set(timeout)
      @timeout = timeout
    end
    
    def to_binary
      return "newtdock" + @command + [4, @timeout].pack("NN")
    end
  end

end
