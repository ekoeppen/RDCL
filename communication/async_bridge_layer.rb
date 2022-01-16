require "rdcl/communication/protocol_layer.rb"
require "async"

module RDCL

  class AsyncBridgeLayer < ProtocolLayer

    attr :receive_buffer_mutex
    
    attr :receive_buffer

    def connected
      @done = false
      Async do |task|
        while not @done do
          @upper.receive(@lower.read)
        end
      end
      super
    end
    
    def disconnected
      @done = true
      super
    end
  
  end
  
end
