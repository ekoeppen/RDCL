require "rdcl/link/dock_cmds/dock_cmd.rb"

module RDCL

  class DockCmdPassword < DockCmd

    attr_accessor :key0
    attr_accessor :key1

    def initialize
      @command = DockCmd::PASSWORD
      @key0 = 0
      @key1 = 0
    end
    
    def set(key0, key1)
      @key0 = key0
      @key1 = key1
    end
    
    def to_s
      return sprintf("Key: %08x%08x", @key0, @key1)
    end
    
    def from_binary(b)
      super(b)
      c = b.unpack("A4 A4 A4 N NN")
      @key0 = c[4]
      @key1 = c[5]
    end
    
    def to_binary
      return "newtdock" + @command + [8, @key0, @key1].pack("NNN")
    end

  end

end
