require 'rdcl/package/package_part.rb'

module RDCL
  
  class NOSPart < PackagePart
    
    attr_accessor :part_frame
    
    def initialize(d, o, fo, l)
      super(d, o, fo, l)
      @part_frame = PkgObjectFactory.new.object_factory(self, 0)
    end
    
  end
  
end
