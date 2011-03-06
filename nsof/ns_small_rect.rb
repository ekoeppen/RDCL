module RDCL
  
  class NSSmallRect < NSObject
    
    def initialize(v = {})
      @value = v
    end

    def to_s
      s = "[left: #{@value[:left]}, top: #{@value[:top]}, right: #{@value[:right]}, bottom: #{@value[:bottom]}]"
      return s;
    end
    
    def to_nsof
      n = NSOF::SMALLRECT.chr + @value[:left].chr + @value[:top].chr + @value[:right].chr + @value[:bottom].chr
      return n;
    end
    
    def to_xml
      s = "[left: #{@value[:left]}, top: #{@value[:top]}, right: #{@value[:right]}, bottom: #{@value[:bottom]}]"
      return s;
    end
    
    def from_nsof(b, factory)
      super(b, factory)
      b.slice!(0)
      c = b.unpack("CCCC")
      @value[:left] = c[0]
      @value[:top] = c[1]
      @value[:right] = c[2]
      @value[:bottom] = c[3]
      b.slice!(0..3)
    end
    
    def to_ruby
      return @value
    end
    
  end

end