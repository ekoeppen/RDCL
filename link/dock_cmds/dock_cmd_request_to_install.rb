require "rdcl/link/dock_cmds/dock_cmd.rb"

module RDCL

  class DockCmdRequestToInstall < DockCmd
    
    def initialize
      @command = DockCmd::REQUEST_TO_INSTALL
    end
    
  end

end
