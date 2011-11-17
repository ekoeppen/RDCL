module RDCL
  
  class NSPrecedent < NSObject

    def initialize(v = 0)
      @value = v
    end

    def to_s
      return "->#{@value.to_s}"
    end
    
    def to_nsof
      return NSOF::PRECEDENT.chr + NSOF::encode_xlong(@value)
    end
    
    def to_xml
      return "<precedent>#{@value}</precedent>"
    end
    
    def from_nsof(b, factory)
      b.slice!(0)
      @value = NSOF::decode_xlong(b)
    end
    
    def to_ruby
      return self
    end
    
    def to_nsobject
      return self
    end
    
  end

end
