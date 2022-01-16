require "rdcl/communication/protocol_layer.rb"
require "rdcl/utils/hexdump.rb"

module RDCL

  class LogLayer < ProtocolLayer
    
    attr_accessor :tag
    attr_accessor :hex
    
    def initialize(tag = "", hex = true)
      @tag = tag
      @hex = hex
    end
  
    def write(data)
      if @lower
        puts "<<< ----- #{tag}"
        if hex
          puts data.hexdump
        else
          puts data.to_s
        end
        puts "<<< ----- "
        @lower.write(data)
      end
    end
    
    def receive(data)
      puts "!!! ----- #{tag}"
      if hex
        puts data.hexdump
      else
        puts data
      end
      puts "!!! ----- "
      if @upper
        @upper.receive(data)
      end
    end
    
  end
  
end
