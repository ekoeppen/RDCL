module RDCL
  
  class PkgFrame < PkgObject

    attr_accessor :map
    
    def initialize(part)
      super(part)
      @value = []
    end
    
    def from_data(offset, size, factory)
      @offset = offset
      @size = size
      @map = factory.ref_factory(@part, offset + 8)
      0.upto(@size / 4 - 4) do |i|
        @value << factory.ref_factory(@part, offset + 12 + i * 4)
      end
    end
    
  end
  
end