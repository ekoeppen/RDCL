module RDCL
  
  class NSArray < NSObject
    
    attr_accessor :array_class

    def initialize(v = [], c = "")
      @value = v
      @ns_class = "array"
      @array_class = c
    end

    def to_s
      s = "[" + array_class.to_s + ": "
      @value.each {|element| s += element.to_s + ", "}
      if s[-2,2] == ", "
        s = s[0..-3]
      end
      s += "]"
      return s;
    end
    
    def to_nsof
      n = NSOF::ARRAY.chr + NSOF::encode_xlong(@value.length) + array_class.to_nsof
      @value.each {|element| n += element.to_nsof}
      return n;
    end
    
    def to_xml
      s = "<array><class>" + array_class.to_xml + "</class>"
      @value.each {|element| s += element.to_xml}
      s += "</array>"
      return s;
    end
    
    def to_ruby
      r = []
      @value.each {|element| r  << element.to_ruby}
      return r
    end
    
    def from_nsof(b, factory)
      super(b, factory)
      b.slice!(0)
      n = NSOF::decode_xlong(b)
      @array_class = factory.from_nsof_factory(b)
      @value = []
      n.times do |i|
        @value << factory.from_nsof_factory(b)
      end
    end
    
  end

end