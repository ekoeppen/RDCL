require "rdcl/communication/serial_layer.rb"
require 'posix_serial_support'

module RDCL

  class SerialLayerPosix < SerialLayer

    attr_accessor :port
    attr :handle
    attr :read_buffer
  
    def connect(port, speed = 38400)
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
        eof = false
        IO.select([@handle], [], [], nil)
        until eof do
          @read_buffer += @handle.sysread(1) rescue eof = true
          eof = true if not IO.select([@handle], [], [], 0)
        end
        count = @read_buffer.length
      else
        until @read_buffer.length >= count do
          IO.select([@handle], [], [], nil)
          @read_buffer += @handle.sysread(count) rescue nil
        end
      end
      return @read_buffer.slice!(0, count)
    end
    
    def write(data)
      @handle.write(data)
    end
    
  end
  
end
