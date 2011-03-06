module RDCL
  
  class PkgRef
    
    attr_accessor :value
    attr_accessor :offset
    attr_accessor :part
    
    def initialize(part)
      @part = part
    end
    
    def from_data(offset, factory)
    end

  end
  
end