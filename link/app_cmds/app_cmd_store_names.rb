require "rdcl/link/app_cmds/app_cmd.rb"

module RDCL

  class AppCmdStoreNames < AppCmd

    def initialize(data = nil)
      @command = AppCmd::STORE_NAMES
      @data = data
    end
    
    def to_s
      return "Store names:\n #{@data}"
    end
    
  end

end
