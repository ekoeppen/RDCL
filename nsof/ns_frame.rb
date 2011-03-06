module RDCL
  
  class NSFrame < NSObject
    
    def initialize(v = [])
      @value = v
      @ns_class = "frame"
    end

    def to_s
      s = "{"
      @value.each do |element|
        s +=
          element[0].to_s + ": " +
          element[1].to_s + ", "
      end
      if s[-2,2] == ", "
        s = s[0..-3]
      end
      s += "}"
      return s;
    end
    
    def to_nsof
      n = NSOF::FRAME.chr + NSOF::encode_xlong(@value.length)
      @value.each {|element| n += element[0].to_nsof}
      @value.each {|element| n += element[1].to_nsof}
      return n;
    end
    
    def to_xml
      s = "<frame>"
      @value.each do |element|
        s += "<slot symbol=\"#{element[0].to_s}\">" +
          element[1].to_xml + "</slot>"
      end
      s += "</frame>"
      return s;
    end
    
    def from_nsof(b, factory)
      super(b, factory)
      @value = []
      b.slice!(0)
      n = NSOF::decode_xlong(b)
      n.times do |i|
        @value << [factory.from_nsof_factory(b), nil]
      end
      n.times do |i|
        @value[i][1] = factory.from_nsof_factory(b)
      end
    end
    
    def to_ruby
      r = {}
      @value.each {|element| r[element[0].to_ruby] = element[1].to_ruby}
      return r
    end
    
  end

end

class Hash

  def to_nsobject
    r = NSFrame.new([])
    self.each do |i, v|
      r.value << [i.to_nsobject, v.to_nsobject]
    end
    return r
  end

  def to_nsof
    return to_nsobject.to_nsof
  end

end
