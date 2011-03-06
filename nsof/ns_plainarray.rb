module RDCL
  
  class NSPlainArray < NSObject
    
    attr_accessor :array_class

    def initialize(v = [])
      @value = v
      @ns_class = "array"
    end

    def to_s
      s = ""
      value.each {|element| s += element.to_s + ", "}
      if s[-2,2] == ", "
        s = s[0..-3]
      end
      return s;
    end
    
    def to_nsof
      n = NSOF::PLAINARRAY.chr + NSOF::encode_xlong(value.length)
      value.each {|element| n += element.to_nsof}
      return n;
    end
    
    def to_xml
      s = "<array>"
      value.each {|element| s += element.to_xml}
      s += "</array>"
      return s;
    end
    
    def from_nsof(b, factory)
      super(b, factory)
      b.slice!(0)
      n = NSOF::decode_xlong(b)
      @value = []
      n.times {|i| @value << factory.from_nsof_factory(b)}
    end
    
    def to_ruby
      r = []
      @value.each {|element| r  << element.to_ruby}
      return r
    end
    
  end

end

class Array

  def to_nsobject
    r = NSPlainArray.new
    self.each do |element|
      r.value << element.to_nsobject
    end
    return r
  end

  def to_nsof
    return to_nsobject.to_nsof
  end

end
