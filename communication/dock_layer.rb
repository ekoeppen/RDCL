require "rdcl/communication/protocol_layer.rb"
require "rdcl/link/dock_cmds/dock_cmd_factory.rb"
require "rdcl/link/app_cmds/app_cmd_progress.rb"
require "rdcl/utils/dfa.rb"
require "rdcl/utils/des.rb"

module RDCL

  class DockLayer < ProtocolLayer
    
    attr_accessor :link
    attr_accessor :packet
    
    def initialize
      @packet = ""
    end
    
    def receive(b)
      @packet += b
      while @packet.length >= 16 and @packet.length - 16 >= @packet.unpack("A4 A4 A4 N")[3]
        handle_packet
      end
    end
    
    def handle_packet
      command = DockCmdFactory.from_binary_factory(@packet)
      packet_length =  @packet.unpack("A4 A4 A4 N")[3] + 16
      if packet_length % 4 != 0 then packet_length += 4 - packet_length % 4 end 
      if command
        if @link
          @link.receive(command)
        end
        @packet.slice!(0, packet_length)
      else
        @packet.slice!(0, @packet.length)
      end
    end
    
    def write(command)
      @lower.write(command.to_binary)
    end
    
  end
  
end
