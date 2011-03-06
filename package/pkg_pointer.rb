require 'rdcl/package/pkg_ref.rb'

module RDCL
  
  class PkgPointer < PkgRef
    
    def initialize(part)
      super(part)
      @value = 0
    end
    
    def from_data(offset, factory)
      @offset = offset
      @value = factory.object_factory(@part, @part.data[offset..-1].unpack("N")[0] - 1 - @part.file_offset)
    end
    
  end
  
end