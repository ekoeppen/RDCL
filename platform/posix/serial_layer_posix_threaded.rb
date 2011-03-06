require "rdcl/communication/serial_layer.rb"

module RDCL

  class SerialLayerPosixThreaded < SerialLayer

    attr_accessor :port
    attr :handle
    attr :read_buffer
  
    def connect(port, speed = nil)
      @port = port
      fd = IO.sysopen(@port, "rb+")
      PosixSerialSupport::set_speed(fd, speed)
      @handle = IO.new(fd)
      @read_buffer = ""
      connected
    end
    
    def disconnect
      @handle.close
      disconnected
    end
  
    def read(count = nil)
      if not count then
        @read_buffer += @handle.sysread(1)
        count = @read_buffer.length
      else
        until @read_buffer.length >= count do
          @read_buffer += @handle.sysread(count)
        end
      end
      return @read_buffer.slice!(0, count)
    end
    
    def write(data)
      @handle.write(data)
    end
    
  end
  
end
