require "rdcl/platform/platform.rb"

if Platform.isWindows?
  require "rdcl/platform/win32/serial_layer_win32.rb"
  require "rdcl/platform/win32/serial_layer_win32_threaded.rb"
else
  require "rdcl/platform/posix/serial_layer_posix.rb"
  require "rdcl/platform/posix/serial_layer_posix_threaded.rb"
end

module RDCL

  class SerialLayerFactory

    def SerialLayerFactory.create
      if Platform.isWindows?
        if RUBY_VERSION =~ /1.9/
#          return SerialLayerWin32Threaded.new
          return SerialLayerWin32.new
        else
          return SerialLayerWin32.new
        end
      else
        if RUBY_VERSION =~ /1.9/
          return SerialLayerPosixThreaded.new
        else
          return SerialLayerPosix.new
        end
      end
    end
    
  end
  
end
