require "rdcl/communication/serial_layer.rb"
require "rdcl/platform/win32/serial_port_win32.rb"

module RDCL

  class SerialLayerWin32 < SerialLayer

    attr_accessor :port
    
    def initialize
      @port = SerialPortWin32.new
    end
  
    def connect(port, speed = nil)
      @port.open(port, speed)
      connected
    end
    
    def disconnect
      @port.close
      disconnected
    end
  
    def read(count = nil)
      return port.read(count)
    end
    
    def write(data)
      port.write(data)
    end
    
  end
  
end
