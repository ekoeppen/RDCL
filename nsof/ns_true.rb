module RDCL
  
  class NSTrue < NSObject

    def initialize
      @value = true
    end

    def to_s
      return "true"
    end
    
    def to_nsof
      return NSOF::IMMEDIATE.chr + NSOF::encode_xlong(0x1a)
    end
    
    def to_xml
      return "<true/>"
    end
    
    def to_ruby
      return true
    end
    
  end

end

class TrueClass

  def to_nsobject
    return NSTrue.new
  end

  def to_nsof
    return to_nsobject.to_nsof
  end

end
