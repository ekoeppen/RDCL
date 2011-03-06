require "rdcl/communication/protocol_layer.rb"
require "rdcl/communication/replay_layer.rb"
require "rdcl/communication/loopback_layer.rb"
require "rdcl/communication/log_layer.rb"
require "rdcl/communication/mnp_packet_layer.rb"
require "rdcl/communication/mnp_logical_layer.rb"
require "rdcl/communication/async_bridge_layer.rb"
require "rdcl/communication/serial_layer_factory.rb"
require "rdcl/communication/dock_layer.rb"
require "rdcl/link/dock_link.rb"

module RDCL

  class SerialDockLink < DockLink
    
    attr_accessor :serial
    attr_accessor :async
    attr_accessor :mnp_packet
    attr_accessor :mnp_logic
    attr_accessor :log
    
    def initialize(settings, log = nil)
      super()

      @serial = SerialLayerFactory.create

      @async = AsyncBridgeLayer.new
      @async.insert_above(@serial)

      @mnp_packet = MNPPacketLayer.new
      @mnp_packet.insert_above(@async)

      @mnp_logic = MNPLogicalLayer.new
      @mnp_logic.insert_above(@mnp_packet)
      
      if log or settings["log_link"] == true
        @log = LogLayer.new
        @log.insert_above(@mnp_logic)
        @dock_layer.insert_above(@log)
      else
        @dock_layer.insert_above(@mnp_logic)
      end

      @serial.connect(settings["serial_port"], settings["serial_speed"])
    end
    
  end
  
end