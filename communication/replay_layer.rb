require "rdcl/communication/protocol_layer.rb"

module RDCL

  class ReplayLayer < ProtocolLayer

    attr_accessor :replay_data
    
    def initialize
      @replay_data = ""
    end
      
    def connect(port)
    end
    
    def disconnect
    end
  
    def read
    end
    
    def read(count)
      if count == nil
        count = @replay_data.length
      end
      begin
        r = @replay_data.slice!(0, count)
      end while r.length == 0
      return r
    end
    
    def write(data)
    end
    
    def receive(data)
    end
  
  end
  
end
