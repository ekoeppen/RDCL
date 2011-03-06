require "rdcl/communication/mnp_packet.rb"

module RDCL
  
  class MNPLinkAcknowledgementPacket < MNPPacket
    
    attr_accessor :sequence_number
    attr_accessor :credit

    def set(sequence_number, credit)
      @sequence_number = sequence_number
      @credit = credit
    end

    def to_binary
      b = [3, LA, @sequence_number, @credit].pack("CCCC")
      return b
    end

    def from_binary(b)
      super
      
      c = b.unpack("CC")
      @sequence_number = c[0]
      @credit = c[1]
      @data = b[2..-1]
      b.slice!(0, b.length)
    end
    
    def to_s
      return "MNPLinkAcknowledgementPacket:\n  Sequence number: #{@sequence_number}\n  Credit: #{@credit}"
    end

  end
  
end
