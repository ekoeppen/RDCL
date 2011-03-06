module RDCL
  
  class MNPPacket
    
    LR = 0x01
    LD = 0x02
    LT = 0x04
    LA = 0x05

    attr_accessor :type
    attr_accessor :header_length
    attr_accessor :raw_data
    attr_accessor :transmitted
    
    def from_binary(b)
      @raw_data = String.new(b)
      if b[0].to_i == 255
        d = b.unpack("CCCC")
        @header_length = (d[1] * 256) + d[2]
        @type = d[3]
        b.slice!(0, 4)
      else
        d = b.unpack("CC")
        @header_length = d[0]
        @type = d[1]
        b.slice!(0, 2)
      end
    end
    
    def to_s
      return "Type #{@type}"
    end
    
    def hexdump
      if @raw_data
        return @raw_data.hexdump
      else
        return ""
      end
    end
    
  end
  
end
