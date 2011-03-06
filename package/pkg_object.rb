module RDCL
  
  class PkgObject
    
    attr_accessor :value
    attr_accessor :size
    attr_accessor :offset
    attr_accessor :part
    
    def initialize(part)
      @part = part
    end
    
    def from_data(offset, size, factory)
    end

  end
  
end