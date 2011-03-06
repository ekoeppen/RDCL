require "rdcl/link/dock_cmds/dock_cmd.rb"

module RDCL

  class DockCmdStartKeyboardPassthrough < DockCmd
    
    def initialize
      @command = DockCmd::START_KEYBOARD_PASSTHROUGH
    end
    
  end

end
