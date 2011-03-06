require "rdcl/link/app_cmds/app_cmd.rb"

module RDCL

  class AppCmdDefaultStore < AppCmd

    def initialize(data = nil)
      @command = AppCmd::DEFAULT_STORE
      @data = data
    end
    
    def to_s
      return "Default store:\n #{@data}"
    end
    
  end

end
