require "rdcl/communication/mnp_packet.rb"

module RDCL
  
  class MNPLinkTransferPacket < MNPPacket
    
    attr_accessor :data
    attr_accessor :sequence_number

    def set(sequence_number, data)
      @sequence_number = sequence_number
      @data = data
    end

    def to_binary
      b = [2, LT, @sequence_number].pack("CCC")
      b += data
      return b
    end

    def from_binary(b)
      super(b)
      
      c = b.unpack("C")
      @sequence_number = c[0]
      @data = b[1..-1]
      b.slice!(0, b.length)
    end
    
    def to_s
      return "MNPLinkTransferPacket:\n  Sequence number: #{@sequence_number}\n  Data:\n#{@data.hexdump}"
    end
    
  end
  
end
