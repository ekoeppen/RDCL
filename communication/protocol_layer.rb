module RDCL

  class ProtocolLayer
  
    attr_accessor :upper
    attr_accessor :lower
  
    def connect
    end
    
    def connected
      if @upper
        @upper.connected
      end
    end
    
    def disconnect
    end
    
    def disconnected
      if @upper
        @upper.disconnected
      end
    end
  
    def write(data)
      if @lower
        @lower.write(data) if @lower
      end
    end
    
    def receive(data)
    end
    
    def insert_above(layer)
      old_upper = layer.upper
      layer.upper = self
      @upper = old_upper
      @lower = layer
    end
  
  end
  
end
