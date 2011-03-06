module RDCL
  
  class NSMagicPointer < NSObject

    def initialize(v = nil)
      @value = v
    end

    def to_s
      return "@#{@value}"
    end
    
    def to_nsof
      return NSOF::IMMEDIATE.chr + NSOF::encode_xlong((@value << 2) | 3)
    end
    
    def to_xml
      return "<magic_pointer>#{@value}</magic_pointer>"
    end
    
    def to_ruby
      return self
    end
    
  end

end