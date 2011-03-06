module RDCL
  
  class NSSymbol < NSObject

    def initialize(v = nil)
      @value = v
      @ns_class = "symbol"
    end

    def to_string
      return @value
    end
    
    def to_nsof
      return NSOF::SYMBOL.chr + NSOF::encode_xlong(value.length) + value
    end
    
    def to_xml
      return "<symbol>#{@value}</symbol>"
    end
    
    def from_nsof(b, factory)
      super(b, factory)
      b.slice!(0)
      l = NSOF::decode_xlong(b)
      @value = b.slice!(0..l - 1)
    end

    def to_ruby
      return @value.intern
    end
    
  end

end

class Symbol

  def to_nsobject
    return NSSymbol.new(self.to_s)
  end

  def to_nsof
    return to_nsobject.to_nsof
  end

end
