require "time"
require "rdcl/package/info_ref.rb"
require "rdcl/package/part_entry.rb"
require "rdcl/package/relocation_header.rb"
require "rdcl/package/package_part.rb"

module RDCL
  
  class PackageDirectory
    
    attr_accessor :signature[8]
    attr_accessor :reserved1
    attr_accessor :flags
    attr_accessor :version
    attr_accessor :copyright
    attr_accessor :name 
    attr_accessor :size
    attr_accessor :creation_date
    attr_accessor :reserved2 
    attr_accessor :reserved3
    attr_accessor :directory_size
    attr_accessor :num_parts
    attr_accessor :parts
    attr_accessor :relocations
    
    DIRECTORY_DATA_SIZE = 52
    RELOCATION_FLAG = 0x04000000

    def initialize
    end
    
    def parse(b)
      header = b.unpack("a8 a4 N N nn nn N N N N N N")
      @signature = header[0]
      @reserved1 = header[1]
      @flags = header[2]
      @version = header[3]
      @size = header[8]
      @creation_date = Time.parse("1904-1-1") + header[9]
      @reserved2 = header[10]
      @reserved3 = header[11]
      @directory_size = header[12]
      @num_parts = header[13]
      @parts = []

      offset = DIRECTORY_DATA_SIZE
      0.upto(@num_parts - 1) do |i|
        p = PartEntry.new
        p.parse(b[offset, PartEntry::PART_ENTRY_DATA_SIZE])
        @parts << p
        offset += PartEntry::PART_ENTRY_DATA_SIZE
      end
      
      @copyright = InfoRef.new(header[4], header[5], header[4] + offset)
      @name = InfoRef.new(header[6], header[7], header[6] + offset)
      
      offset = @directory_size
      if @signature == "package1" && (@flags & RELOCATION_FLAG == RELOCATION_FLAG)
        @relocations = RelocationHeader.new
        @relocations.parse(b[offset, RelocationHeader::RELOCATION_HEADER_DATA_SIZE])
        offset += @relocations.relocationSize
      end
      
      @parts.each do |part|
        part.file_offset = part.offset + offset
        part.set_part_from_file_data(b)
      end
    end
    
  end

end