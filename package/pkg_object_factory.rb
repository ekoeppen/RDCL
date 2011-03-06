require 'rdcl/package/pkg_array.rb'
require 'rdcl/package/pkg_binary.rb'
require 'rdcl/package/pkg_character.rb'
require 'rdcl/package/pkg_frame.rb'
require 'rdcl/package/pkg_integer.rb'
require 'rdcl/package/pkg_magic_pointer.rb'
require 'rdcl/package/pkg_pointer.rb'
require 'rdcl/package/pkg_real.rb'
require 'rdcl/package/pkg_special.rb'
require 'rdcl/package/pkg_string.rb'
require 'rdcl/package/pkg_symbol.rb'

module RDCL
  
  class PkgObjectFactory
    
    attr_accessor :objects
    
    INTEGER_TAG = 0b00
    POINTER_TAG = 0b01
    SPECIAL_TAG = 0b10
    MAGIC_POINTER_TAG = 0b11
    CHARACTER_TAG = 0b0110
    
    TAG_MASK = 0b11
    CHARACTER_TAG_MASK = 0b1111
    
    BINARY_TAG = 0b01000000
    ARRAY_TAG =  0b01000001
    FRAME_TAG =  0b01000011
    
    OBJECT_TAG_MARK = 0b01000011
    
    def initialize
      @objects = []
    end
    
    def ref_factory(part, offset)
      r = nil
      ref = part.data[offset..-1].unpack("N")[0]
      if ref & CHARACTER_TAG_MASK == CHARACTER_TAG
        r = PkgCharacter.new
      else
        case ref & TAG_MASK
        when INTEGER_TAG then r = PkgInteger.new(part)
        when POINTER_TAG then r = PkgPointer.new(part)
        when SPECIAL_TAG then r = PkgSpecial.new(part)
        when MAGIC_POINTER_TAG then r = PkgMagicPointer.new
        end
      end
      r.from_data(offset, self)
      return r
    end
    
    def object_factory(part, offset)
      r = nil
      header = part.data[offset..-1].unpack("UUUUN")
      size = (((header[0] << 8) + header[1]) << 8) + header[2]
      case header[3] & OBJECT_TAG_MARK
      when BINARY_TAG then r = PkgBinary.new(part)
      when ARRAY_TAG then r = PkgArray.new(part)
      when FRAME_TAG then r = PkgFrame.new(part)
      end
      r.from_data(offset, size, self)
      return r
    end
    
  end
  
end