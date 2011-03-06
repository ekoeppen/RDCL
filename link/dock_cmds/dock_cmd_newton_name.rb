require "rdcl/link/dock_cmds/dock_cmd.rb"
require "rdcl/utils/unicode.rb"

module RDCL

  class DockCmdNewtonName < DockCmd

    attr_accessor :name
    attr_accessor :version_info
    
    INFO_SYMBOLS = [
      :newton_unique_id,
      :manufacturer_id,
      :machine_type,
      :rom_version,
      :rom_stage,
      :ram_size,
      :screen_height,
      :screen_width,
      :system_update_version,
      :object_system_version,
      :internal_store_signature,
      :vertical_screen_resolution,
      :horizontal_screen_resolution,
      :screen_depth
    ]
    
    def initialize
      @command = DockCmd::NEWTON_NAME
      @name = ""
      @version_info = {}
    end
    
    def to_s
      r = "Name: #{@name}\n"
      INFO_SYMBOLS.each do |s|
        r += s.to_s + ": " + @version_info[s].to_s + "\n"
      end
      r.chop
      return r
    end
    
    def from_binary(b)
      super(b)
      c = b.unpack("A4A4A4N N NNNNNNNNNNNNNN")
      version_info_length = c[4]
      (0 ... INFO_SYMBOLS.length).each do |i|
        @version_info[INFO_SYMBOLS[i]] = c[i + 5]
      end
      @name = String.from_utf16be(b[0x5c..-1])
    end

  end

end
