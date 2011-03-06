module RDCL
  
  class NSInteger < NSObject

    def initialize(v = 0)
      @value = v
    end

    def to_s
      return @value.to_s
    end
    
    def to_nsof
      return NSOF::IMMEDIATE.chr + NSOF::encode_xlong(@value << 2)
    end
    
    def to_xml
      return "<integer>#{@value}</integer>"
    end
    
    def from_nsof(b, factory)
      super(b, factory)
      b.slice!(0)
      @value = NSOF::decode_xlong(b) >> 2
    end
    
    def to_ruby
      return @value
    end
    
  end

end

class Integer

  def to_nsobject
    return NSInteger.new(self)
  end

  def to_nsof
    return to_nsobject.to_nsof
  end

end
