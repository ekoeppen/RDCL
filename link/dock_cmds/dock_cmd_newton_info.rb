require "rdcl/link/dock_cmds/dock_cmd.rb"

module RDCL

  class DockCmdNewtonInfo < DockCmd

    attr_accessor :protocol_version
    attr_accessor :key0
    attr_accessor :key1
    
    def initialize
      @command = DockCmd::NEWTON_INFO
      @protocol_version = 0
      @key0 = 0
      @key1 = 0
    end
    
    def to_s
      r = sprintf("Protocol version: %s, key = %08x%08x", @protocol_version, @key0, @key1)
      return r
    end
    
    def from_binary(b)
      super(b)
      c = b.unpack("A4 A4 A4 N N NN")
      @protocol_version = c[4]
      @key0 = c[5]
      @key1 = c[6]
    end

  end

end
