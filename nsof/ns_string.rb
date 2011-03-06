module RDCL
  
  class NSString < NSObject

    def initialize(v = nil)
      @value = v
      @ns_class = "string"
    end

    def to_s
      return @value
    end
    
    def to_nsof
      return NSOF::STRING.chr + NSOF::encode_xlong(value.length * 2 + 2) +
        value.to_utf16_be + 0.chr + 0.chr
    end
    
    def to_xml
      return "<string>#{@value}</string>"
    end
    
    def from_nsof(b, factory)
      super(b, factory)
      b.slice!(0)
      l = NSOF::decode_xlong(b) / 2
      @value = String.from_utf16be(b[0..(l - 1) * 2 - 1])
      b.slice!(0..l * 2 - 1)
    end

    def to_ruby
      return @value
    end
    
  end

end

class String
  
  def to_nsobject
    return NSString.new(self)
  end
  
  def to_nsof
    return to_nsobject.to_nsof
  end

end
