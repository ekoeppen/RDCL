require "rdcl/link/dock_cmds/dock_cmd.rb"

module RDCL

  class DockCmdWhichIcons < DockCmd

    attr_accessor :icons
    
    BACKUP_ICON = 1 
    RESTORE_ICON = 2 
    INSTALL_ICON = 4 
    IMPORT_ICON = 8 
    SYNC_ICON = 16 
    KEYBOARD_ICON = 32
    ALL_ICONS = 63
        
    def initialize(icons = ALL_ICONS)
      @command = DockCmd::WHICH_ICONS
      @icons = icons
    end
    
    def to_binary
      return "newtdock" + @command + [4, @icons].pack("NN")
    end

  end

end
