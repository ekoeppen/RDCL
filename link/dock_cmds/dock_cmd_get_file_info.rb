require "rdcl/link/dock_cmds/dock_cmd.rb"
require "rdcl/nsof/ns_string.rb"

module RDCL

  class DockCmdGetFileInfo < DockCmd
    
    attr_accessor :name
    
    def from_binary(b)
      super(b)
      string = NSString.new;
      string.from_nsof(@data[1..-1], NSObjectFactory.new)
      @name = string.value
    end
    
  end

end
