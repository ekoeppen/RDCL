require "rdcl/communication/mnp_link_request_packet.rb"
require "rdcl/communication/mnp_link_acknowledgement_packet.rb"
require "rdcl/communication/mnp_link_transfer_packet.rb"
require "rdcl/communication/mnp_link_disconnect_packet.rb"

module RDCL
  
  class MNPPacketFactory
    
    LR = 0x01
    LD = 0x02
    LT = 0x04
    LA = 0x05

    PACKET_MAP = [
      [LR, :MNPLinkRequestPacket],
      [LD, :MNPLinkDisconnectPacket],
      [LT, :MNPLinkTransferPacket],
      [LA, :MNPLinkAcknowledgementPacket]
    ]

    def MNPPacketFactory.from_binary_factory(b)
      r = nil
      class_symbol = nil
      c = b.unpack("CC")
      PACKET_MAP.each do |cmd|
        if cmd[0] == c[1]
          class_symbol = cmd[1]
        end
      end
      if class_symbol
        r = RDCL.const_get(class_symbol).new
        r.from_binary(b)
      end
      return r
    end

  end
  
end