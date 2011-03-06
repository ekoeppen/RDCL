module RDCL
  
  class NSUnicodeCharacter < NSObject

    def initialize(v = 0)
      @value = v
    end

    def to_s
      return @value.to_s
    end
    
    def to_nsof
      return NSOF::UNICODECHARACTER.chr + (@value >> 8).chr + (@value & 0xff).chr
    end
    
    def to_xml
      return "<unicodecharacter>#{@value}</unicodecharacter>"
    end
    
    def from_nsof(b, factory)
      super(b, factory)
      b.slice!(2)
#      @value = NSOF::decode_xlong(b) >> 2
    end
    
    def to_ruby
      return @value
    end
    
  end

end