module RDCL
  
  class RelocationHeader
    
    attr_accessor :reserved
    attr_accessor :relocation_size
    attr_accessor :page_size
    attr_accessor :num_entries
    attr_accessor :base_address
    
    RELOCATION_HEADER_DATA_SIZE = 20
    
    def initialize
    end
    
    def parse(b)
      header = b.unpack("N N N N N")
      @reserved = header[0]
      @relocation_size = header[1]
      @page_size = header[2]
      @num_entries = header[3]
      @base_address = header[4]
    end
    
  end
  
end