module RDCL
  
  class NSCharacter < NSObject

    def initialize(v = nil)
      @value = v
    end

    def to_string
      return @value
    end
    
    def to_nsof
      return NSOF::CHARACTER.chr + NSOF::encode_xlong((@value.chr << 4) | 6)
    end
    
    def to_xml
      return @value
    end
    
    def to_ruby
      return @value
    end
    
  end

end