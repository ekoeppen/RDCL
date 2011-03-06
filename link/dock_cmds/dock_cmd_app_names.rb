require "rdcl/link/dock_cmds/dock_cmd.rb"

module RDCL

  class DockCmdAppNames < DockCmd
  
    def initialize
      @command = DockCmd::APP_NAMES
    end
    
  end

end
