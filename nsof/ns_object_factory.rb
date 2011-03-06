require "rdcl/nsof/ns_object.rb"
require "rdcl/nsof/ns_plainarray.rb"
require "rdcl/nsof/ns_array.rb"
require "rdcl/nsof/ns_string.rb"
require "rdcl/nsof/ns_frame.rb"
require "rdcl/nsof/ns_integer.rb"
require "rdcl/nsof/ns_symbol.rb"
require "rdcl/nsof/ns_binary.rb"
require "rdcl/nsof/ns_precendent.rb"
require "rdcl/nsof/ns_true.rb"
require "rdcl/nsof/ns_magic_pointer.rb"
require "rdcl/nsof/ns_small_rect.rb"
require "rdcl/nsof/ns_unicodecharacter.rb"
require "rdcl/nsof/ns_nil.rb"
require "rdcl/nsof/nsof.rb"

module RDCL
  
  class NSObjectFactory
    
    attr_accessor :objects

    NSOBJECT_MAP = [
      [NSOF::IMMEDIATE, :immediate],
      [NSOF::CHARACTER, :NSCharacter],
      [NSOF::UNICODECHARACTER, :NSUnicodeCharacter],
      [NSOF::BINARYOBJECT, :NSBinary],
      [NSOF::ARRAY, :NSArray],
      [NSOF::PLAINARRAY, :NSPlainArray],
      [NSOF::FRAME, :NSFrame],
      [NSOF::SYMBOL, :NSSymbol],
      [NSOF::STRING, :NSString],
      [NSOF::PRECEDENT, :NSPrecedent],
      [NSOF::NIL, :NSNil],
      [NSOF::SMALLRECT, :NSSmallRect],
      [NSOF::LARGEBINARY, nil],
    ]
    
    def initialize
      @objects = []
    end

    def from_nsof_factory(b)
      r = nil
      class_symbol = nil
      c = b.unpack("C")
      NSOBJECT_MAP.each do |obj|
        if obj[0] == c[0]
          class_symbol = obj[1]
        end
      end
      if not class_symbol
        puts "Error decoding code #{c[0]}:"
        puts b[0..31].hexdump
      end
      
      #puts "-------------- #{@objects.length}"
      #puts b[0..31].hexdump
      #puts ">>>=== #{class_symbol}"
      
      if class_symbol == :immediate
        b.slice!(0)
        v = NSOF::decode_xlong(b)
        if v & 3 == 0
          r = NSInteger.new(v >> 2)
        elsif v & 0xf == 6
          r = NSCharacter.new((v >> 4) & 0xffff)
        elsif v == 0x1a
          r = NSTrue.new
        elsif v == 2
          r = NSNil.new
        elsif v & 3 == 3
          r = NSMagicPointer.new(v)
        end
        @objects << r
      else
        r = RDCL.const_get(class_symbol).new
        r.from_nsof(b, self)
      end

      if class_symbol == :NSPrecedent
        #puts "--> #{r.value}"
        r = @objects[r.value]
      end

      return r
    end

  end
  
end
