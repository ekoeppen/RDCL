require "rdcl/link/dock_cmds/dock_cmd.rb"

module RDCL

  class DockCmdLoadPackage < DockCmd
    
    def initialize(data)
      @command = DockCmd::LOAD_PACKAGE
      @data = data
    end
    
  end

end
