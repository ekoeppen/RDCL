require "rdcl/link/dock_cmds/dock_cmd.rb"

module RDCL

  class DockCmdGetAppNames < DockCmd
  
    ALL_STORES_NAMES_SOUPS = 0
    CURRENT_STORE_NAMES_SOUPS = 1
    ALL_STORES_NAMES = 2
    CURRENT_STORE_NAMES = 3
    
    attr_accessor :what

    def initialize(what)
      @command = DockCmd::GET_APP_NAMES
      @what = what
    end
    
    def to_binary
      return "newtdock" + @command + [4, @what].pack("NN")
    end
  
  end

end
