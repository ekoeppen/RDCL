require 'rdcl/package/package_part_factory.rb'
require 'rdcl/package/pkg_object_factory.rb'

module RDCL
  
  class PartEntry
    
    attr_accessor :offset
    attr_accessor :size 
    attr_accessor :size2
    attr_accessor :type
    attr_accessor :reserved1
    attr_accessor :flags
    attr_accessor :info
    attr_accessor :reserved2
    attr_accessor :file_offset
    attr_accessor :part
    
    PART_ENTRY_DATA_SIZE = 32
    
    def initialize
    end
    
    def parse(b)
      entry = b.unpack("N N N a4 N N nn N")
      @offset = entry[0]
      @size = entry[1]
      @size2 = entry[2]
      @type = entry[3]
      @reserved1 = entry[4]
      @flags = entry[5]
      @info = InfoRef.new(entry[6], entry[7])
      @reserved2 = entry[8]
      @file_offset = 0
    end
    
    def set_part_from_file_data(file_data)
      @part = PackagePartFactory::part_factory(@flags, file_data, @offset, @file_offset, @size)
    end
    
  end
  
end