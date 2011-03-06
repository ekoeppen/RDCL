require "rdcl/link/dock_cmds/dock_cmd.rb"

module RDCL

  class DockCmdSetCurrentSoup < DockCmd
  
    def initialize(data)
      @data = (data + 0.chr).to_utf16_be
      @command = DockCmd::SET_CURRENT_SOUP
    end

  end

end
