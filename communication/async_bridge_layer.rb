require "rdcl/communication/protocol_layer.rb"
require "thread"

module RDCL

  class AsyncBridgeLayer < ProtocolLayer

    attr_accessor :receive_thread
    
    attr :receive_buffer_mutex
    attr :receive_buffer_condition
    
    attr :receive_buffer

    def connected
      @receive_buffer = ""
      @receive_mutex = Mutex.new
      @receive_buffer_mutex = Mutex.new
      @receive_buffer_condition = ConditionVariable.new
      @receive_thread = Thread.new do
        loop do
          data = @lower.read
          @receive_buffer_mutex.synchronize do
            @receive_buffer += data 
            @receive_buffer_condition.signal
          end
          if @receive_buffer != ""
            @upper.receive(@receive_buffer)
          end
        end
      end
      super
    end
    
    def disconnected
      @receive_thread.terminate
      super
    end
  
    def read(count = nil)
      r = ""
      if count == nil and @receive_buffer.length > 0
        count = @receive_buffer.length
      else
        while count and @receive_buffer.length < count or @receive_buffer.length == 0
          @receive_buffer_mutex.synchronize do
            @receive_buffer_condition.wait(@receive_buffer_mutex)
          end
        end
        if not count
          count = @receive_buffer.length
        end
      end
      @receive_buffer_mutex.synchronize do
        r = @receive_buffer.slice!(0, count)
      end
      return r
    end
    
  end
  
end
