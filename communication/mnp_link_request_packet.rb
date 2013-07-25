require "rdcl/communication/mnp_packet.rb"

module RDCL
  
  class MNPLinkRequestPacket < MNPPacket
    
    attr_accessor :framing_mode
    attr_accessor :max_outstanding
    attr_accessor :max_info_length
    attr_accessor :data_phase_opt
    attr_accessor :header_data
    
    def set(framing_mode, max_outstanding, max_info_length, data_phase_opt)
      @framing_mode = framing_mode
      @max_outstanding = max_outstanding
      @max_info_length = max_info_length
      @data_phase_opt = data_phase_opt
    end
    
    def to_binary
      b = [23, 1, 
        2,
        1, 6, 1, 0, 0, 0, 0, 255,
        2, 1, @framing_mode,
        3, 1, @max_outstanding,
        4, 2, @max_info_length,
        8, 1, @data_phase_opt].pack("CC C CCCCCCCC CCC CCC CCv CCC")
      return b;
    end
    
    def from_binary(b)
      super
      
      @header_data = String.new(b)

      # remove fixed fields
      n = 9
      b.slice!(0, n)

      n = 3
      c = b.unpack("CCC")
      @framing_mode = c[2]
      b.slice!(0, n)
      
      n = 3
      c = b.unpack("CCC")
      @max_outstanding = c[2]
      b.slice!(0, n)

      n = 4
      c = b.unpack("CCv")
      @max_info_length = c[2]
      b.slice!(0, n)

      n = 3
      c = b.unpack("CCC")
      @data_phase_opt = c[2]
      b.slice!(0, n)
    end
    
    def to_s
      return "MNPLinkRequestPacket:\n  Framing mode: #{@framing_mode}\n  Max. info length: #{@max_info_length}\n  Max. outstanding packets: #{@max_outstanding}\n  Data phase opt.: #{@data_phase_opt}"
    end
    
  end
  
end
