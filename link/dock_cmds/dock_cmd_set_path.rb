require "rdcl/link/dock_cmds/dock_cmd.rb"
require "rdcl/nsof/ns_object_factory.rb"

module RDCL

  class DockCmdSetPath < DockCmd
    
    attr_accessor :path
    
    def from_binary(b)
      super(b)
      @data.slice!(0)
      p = NSObjectFactory.new.from_nsof_factory(@data)
      @path = ""
      p.value.each do |dir|
        @path << dir.value
        if dir.value != "/"
          @path << '/' 
        end
      end
    end
    
  end

end
