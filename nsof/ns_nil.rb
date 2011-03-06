module RDCL
  
  class NSNil < NSObject

    def initialize
      @value = nil
    end

    def to_s
      return "nil"
    end
    
    def to_nsof
      return NSOF::NIL.chr
    end
    
    def from_nsof(b, factory)
      super(b, factory)
      b.slice!(0)
      @value = nil
    end

    def to_xml
      return "<nil/>"
    end
    
    def to_ruby
      return nil
    end
    
  end

end

class NilClass

  def to_nsobject
    return NSNil.new
  end

  def to_nsof
    return to_nsobject.to_nsof
  end

end
