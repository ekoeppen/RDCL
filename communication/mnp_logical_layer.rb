require "rdcl/communication/protocol_layer.rb"
require "rdcl/communication/mnp_packet.rb"
require "rdcl/utils/dfa.rb"
require "thread"

module RDCL

  class MNPLogicalLayer < ProtocolLayer
    
    include DFA
    
    attr :local_credit
    attr :peer_credit
    attr :local_send_sequence_number
    attr :local_recv_sequence_number
    attr :peer_send_sequence_number
    attr :peer_recv_sequence_number
    attr :max_info_length
    attr :send_queue
    
    def initialize
      @current_frame_data = ""
      @packet = nil
      @local_credit = 1
      @peer_credit = 8
      @local_send_sequence_number = 1
      @local_recv_sequence_number = 0
      @peer_send_sequence_number = 0
      @peer_recv_sequence_number = 0
      @max_info_length = 240
      @send_queue = []

      init_automaton :idle, [:idle]
      transition do |s, a|
        new_state = case [s, a]
        when [:idle, MNPPacket::LR] then send_link_request_response; :link_request
        when [:link_request, MNPPacket::LR] then send_link_request_response; :link_request
        when [:link_request, MNPPacket::LA] then disconnect; :data_phase
        when [:link_request, MNPPacket::LD] then disconnect; :idle
        when [:link_request, MNPPacket::LT] then disconnect; :idle
        when [:data_phase, MNPPacket::LR] then disconnect; :idle
        when [:data_phase, MNPPacket::LT] then handle_link_transfer; :data_phase
        when [:data_phase, MNPPacket::LA] then handle_link_acknowledgement; :data_phase
        when [:data_phase, MNPPacket::LD] then disconnect; :idle
        else nil
        end
        new_state = s if not new_state
        new_state
      end
    end
    
    def send_link_request_response
      @max_info_length = @packet.max_info_length
      if @packet.data_phase_opt & 1 == 1
        @max_info_length = 240
      end
      @window_size = @packet.max_outstanding
      @local_credit = @window_size
      p = MNPLinkRequestPacket.new
      p.set(@packet.framing_mode, @packet.max_outstanding, @packet.max_info_length, @packet.data_phase_opt)
      #p.set_raw(@packet.header_data)
      @lower.write(p)
    end
    
    def send_link_acknowledgement
#      puts ":::: ack packet number #{@peer_send_sequence_number}"
      p = MNPLinkAcknowledgementPacket.new
      p.set(@peer_send_sequence_number, @peer_credit)
      @lower.write(p)
    end
    
    def handle_link_acknowledgement
      @peer_recv_sequence_number = @packet.sequence_number
      @local_credit = @packet.credit

#      puts "ACK packet #{@send_queue[0].sequence_number}"
#      print "Before: {"
#      @send_queue[0..9].each {|p| print"#{p.sequence_number} "}
#      puts "}"

      while @send_queue.length > 0 and @send_queue[0].sequence_number < @peer_recv_sequence_number
        @send_queue.delete_at(0)
      end
      if @send_queue.length > 0 and @send_queue[0].sequence_number == @peer_recv_sequence_number
        @send_queue.delete_at(0)
      end

#      print "After:  {"
#      @send_queue[0..9].each {|p| print"#{p.sequence_number} "}
#      puts "}"

      if @send_queue.length > 0
        write("")
      end
    end
    
    def handle_link_transfer
      @peer_send_sequence_number = @packet.sequence_number
#      puts ":::: got packet number #{@peer_send_sequence_number}"
      send_link_acknowledgement

      if @upper
        @upper.receive(@packet.data)
      end
    end
    
    def write(packet)
      while packet.length > 0
        data = packet.slice!(0, @max_info_length)
        p = MNPLinkTransferPacket.new
        p.set(@local_send_sequence_number, data)
        @local_send_sequence_number = (@local_send_sequence_number + 1) % 256
        @send_queue << p
      end

      if @send_queue.length > 0 and @local_credit > 0
        if not @send_queue[0].transmitted
          @send_queue[0].transmitted = true
        else
#          sleep(1)
        end
        @lower.write(@send_queue[0])
        @local_credit -= 1
      end
    end
    
    def receive(packet)
      @packet = packet
      automaton_input(@packet.type)
    end
    
  end
  
end
