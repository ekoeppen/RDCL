module RDCL
  
  class PackagePart
    
    attr_accessor :file_offset
    attr_accessor :data
    attr_accessor :offset
    attr_accessor :length
    
    PROTOCOL_PART = 0x00000000
    NOS_PART = 0x00000001
    RAW_PART = 0x00000002
    PART_TYPE_MASK = 0x00000003

    AUTO_LOAD = 0x00000010
    AUTO_REMOVE = 0x00000020
    NOTIFY = 0x00000080 
    AUTO_COPY = 0x00000100
    
    def initialize(d, o, fo, l)
      @data = d
      @file_offset = fo
      @offset = o
      @length = l
    end
    
  end
  
end
