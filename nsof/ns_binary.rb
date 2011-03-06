require "rdcl/utils/hexdump.rb"

module RDCL
  
  class NSBinary < NSObject
    
    def initialize(v = [])
      @value = v
      @ns_class = "binary"
    end

    def to_s
      return "Class:" + @ns_class.to_s + "\n" + @value.hexdump
    end
    
    def to_nsof
      n = NSOF::BINARYOBJECT.chr + NSOF::encode_xlong(@value.length) + @ns_class.to_nsof + @value
      return n;
    end
    
    def to_xml
      return "<binary class='#{@ns_class.to_s}'>" + [value].pack("m").chomp + "</binary>"
    end
    
    def from_nsof(b, factory)
      super(b, factory)
      b.slice!(0)
      n = NSOF::decode_xlong(b)
      @ns_class = factory.from_nsof_factory(b).to_ruby
      @value = b.slice!(0..n - 1)
    end
    
    def to_ruby
      r = self
      case @ns_class
      when :company, :person, :workPhone, :faxPhone, :email then
        r = String::from_utf16be(@value[0..-2])
        r.ns_class = @ns_class
      end
      return r
    end
    
    def to_nsobject
      return self
    end
    
  end

end

class String
  
  attr_accessor :ns_class
  
end
