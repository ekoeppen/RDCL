require "rdcl/communication/protocol_layer.rb"
require "rdcl/communication/mnp_packet_factory.rb"
require "rdcl/utils/dfa.rb"
require "rdcl/utils/crc.rb"
require "thread"

module RDCL

  class MNPPacketLayer < ProtocolLayer
    
    include DFA
    
    DLE = 0x10
    SYN = 0x16
    STX = 0x02
    ETX = 0x03
    
    attr_accessor :current_frame_data
    attr :receive_mutex
    attr :crc_in
    attr :current_crc_in
    attr :crc_out
    
    def initialize
      @receive_mutex = Mutex.new
      @current_frame_data = ""
      @packets = []
      @crc_in = CRC16.new
      @crc_out = CRC16.new
      @current_crc_in = 0
      init_automaton :outside_packet, [:packet_end]
      transition do |s, a|
        state_table = [
          [:outside_packet, SYN, :start_syn, nil],
          [:start_syn, DLE, :start_dle, nil],
          [:start_dle, STX, :inside_packet,
            lambda {@current_frame_data = ""; crc_in.reset}],
          [:inside_packet, DLE, :dle_in_packet, nil],
          [:inside_packet, (0..255), :inside_packet,
            lambda {crc_in.update(@last_char); @current_frame_data += @last_char.chr}], 
          [:dle_in_packet, DLE, :inside_packet,
            lambda {@current_frame_data += @last_char.chr}],
          [:dle_in_packet, ETX, :end_etx,
            lambda {crc_in.update(@last_char)}],
          [:end_etx, (0..255), :end_crc1,
            lambda {@current_crc_in = @last_char}],
          [:end_crc1, (0..255), :packet_end,
            lambda {@current_crc_in += (@last_char << 8)}],
          [:dle_in_packet, (0..255), :outside_packet, nil],
          [:start_dle, (0..255), :outside_packet, nil],
          [:start_syn, (0..255), :outside_packet, nil],
          [:packet_end, SYN, :start_syn, nil],
          [:packet_end, (0..255), :outside_packet, nil],
        ]
        new_state = nil
        state_table.each do |state|
          if state[0] === s and state[1] === a
            new_state = state[2]
            state[3].call if state[3]
            break
          end
        end
        new_state = s if not new_state
        #puts "#{s}(#{a}) -> #{new_state}"
        new_state
      end
    end
    
    def read_frame
      begin
        @last_char = @lower.read(1)[0]
      end until automaton_input(@last_char)
    end

    def read(count = nil)
      p = ""
      if count == nil
        read_frame
        @receive_mutex.synchronize do
          p = MNPPacketFactory.from_binary_factory(@current_frame_data)
          @current_frame_data.slice!(0, @current_frame_data.length)
        end
      end
      return p
    end
    
    def write(p)
      @crc_out.reset
      b = ""
      b += SYN.chr + DLE.chr + STX.chr
      payload = p.to_binary
      payload.each_byte do |byte|
        if byte == DLE
          b += DLE.chr
        end
        b += byte.chr
        @crc_out.update(byte)
      end
      b += DLE.chr
      b += ETX.chr
      @crc_out.update(ETX)
      b += [@crc_out.value].pack("v")
#      puts "<<< -------------------------------------"
#      puts b.hexdump

      @lower.write(b)
    end
    
    def receive(data)
      count = 0
      data.each_byte do |c|
        count = count.next
        @last_char = c
        if automaton_input(@last_char) and @crc_in.value = @current_crc_in
#          puts ">>> -------------------------------------"
#          puts @current_frame_data.hexdump
          p = MNPPacketFactory.from_binary_factory(@current_frame_data)
          @upper.receive(p) if p
        end
      end
      data.slice!(0, count)
    end
    
  end
  
end
