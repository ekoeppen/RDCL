require 'rdcl/package/pkg_object.rb'

module RDCL
  
  class PkgArray < PkgObject
    
    attr_accessor :array_class
    
    def initialize(part)
      super(part)
      @value = []
    end
    
    def from_data(offset, size, factory)
      @offset = offset
      @size = size
      @array_class = factory.ref_factory(@part, offset + 8)
      0.upto(@size / 4 - 4) do |i|
        @value << factory.ref_factory(@part, offset + 12 + i * 4)
      end
    end
    
  end
  
end