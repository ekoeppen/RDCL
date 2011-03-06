module RDCL
  
  class InfoRef
    
    attr_accessor :length
    attr_accessor :offset
    attr_accessor :file_offset
    
    def initialize(o, l, f = 0)
      @file_offset = f
      @length = l
      @offset = o
    end
    
  end
  
end