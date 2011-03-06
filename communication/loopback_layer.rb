require "rdcl/communication/protocol_layer.rb"

module RDCL

  class LoopbackLayer < ProtocolLayer

    attr_accessor :loopback_data
    
    def initialize
      @loopback_data = ""
    end
      
    def connect(port)
    end
    
    def disconnect
    end
  
    def read
    end
    
    def read(count = nil)
      if count == nil
        count = @loopback_data.length
      end
      while @loopback_data.length < count do
      end
      return @loopback_data.slice!(0, count)
    end
    
    def write(data)
      @loopback_data += data
    end
    
    def receive(data)
    end
  
  end
  
end
