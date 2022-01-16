require "rdcl/communication/protocol_layer.rb"
require "rdcl/platform/platform.rb"
require "rdcl/platform/win32/serial_layer_win32.rb" if Platform.isWindows?

module RDCL

  class SerialLayer < ProtocolLayer

    def connect(port, speed)
    end
    
    def disconnect
    end
  
    def write(data)
    end
    
  end
  
end
