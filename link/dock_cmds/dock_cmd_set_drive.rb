require "rdcl/link/dock_cmds/dock_cmd.rb"

module RDCL

  class DockCmdSetDrive < DockCmd
    
    attr_accessor :drive

    def from_binary(b)
      super(b)
      string = NSString.new;
      string.from_nsof(@data[1..-1], NSObjectFactory.new)
      @drive = string.value
    end

  end

end
