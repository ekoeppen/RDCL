require 'rdcl/package/package_part.rb'
require 'rdcl/package/nos_part.rb'
require 'rdcl/package/raw_part.rb'
require 'rdcl/package/protocol_part.rb'

module RDCL

  class PackagePartFactory

    def PackagePartFactory::part_factory(flags, file_data, offset, file_offset, size)
      f = nil
      case flags & PackagePart::PART_TYPE_MASK
      when PackagePart::PROTOCOL_PART then f = :ProtocolPart 
      when PackagePart::NOS_PART then f = :NOSPart
      when PackagePart::RAW_PART then f = :RawPart
      end
      return RDCL.const_get(f).new(file_data[file_offset, size], offset, file_offset, size)
    end
    
  end
  
end
