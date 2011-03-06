module RDCL
  
  class NSOF
    
    IMMEDIATE = 0
    CHARACTER = 1
    UNICODECHARACTER = 2
    BINARYOBJECT = 3
    ARRAY = 4
    PLAINARRAY = 5
    FRAME = 6
    SYMBOL = 7
    STRING = 8
    PRECEDENT = 9
    NIL = 10
    SMALLRECT = 11
    LARGEBINARY = 12

    NSOFVERSION = 0x02
    
    def NSOF.encode_xlong(long)
      nsof = ""
      if long < 254
        nsof += long.chr
      else
        nsof = [255, long].pack("CN")
      end
      return nsof
    end
    
    def NSOF.decode_xlong(b)
      n = b.unpack("C")[0]
      b.slice!(0)
      if n > 254
        n = b.unpack("N")[0]
        b.slice!(0..3)
      end
      return n
    end
    
    def NSOF.padding(data)
      padding = 4 - data.length % 4
      padding = 0 if padding == 4
      return 0.chr * padding
    end

  end
  
end