require "rdcl/link/dock_cmds/dock_cmd.rb"

module RDCL

  class DockCmdResult < DockCmd

    attr_accessor :result

    def initialize
      @command = DockCmd::RESULT
      @result = 0
    end
    
    def set(result)
      @result = result
    end
    
    def to_s
      return "Result: #{@result}"
    end
    
    def from_binary(b)
      super(b)
      c = b.unpack("A4A4A4NN")
      @result = c[4]
      if @result > 0x80000000
        @result = -(0xffffffff ^ c[4]) - 1
      end
    end
    
    def to_binary
      return "newtdock" + @command + [4, @result].pack("NN")
    end

  end

end
