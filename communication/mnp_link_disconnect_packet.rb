require "rdcl/communication/mnp_packet.rb"

module RDCL
  
  class MNPLinkDisconnectPacket < MNPPacket
    
    attr_accessor :reason_code
    attr_accessor :user_code

    def from_binary(b)
      super

      n = 3
      c = b.unpack("CCC")
      @reason_code = c[2]
      b.slice!(0, n)
      
      if @header_length == 7
        n = 3
        c = b.unpack("CCC")
        @user_code = c[2]
        b.slice!(0, n)
      end
    end
    
    def to_s
      return "MNPLinkDisconnectPacket:\n  Reason code: #{@reason_code}\n  User code: #{@user_code}"
    end

  end
  
end
