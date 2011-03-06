require "rdcl/link/app_cmds/app_cmd.rb"

module RDCL

  class AppCmdAppList < AppCmd

    def initialize(data = nil)
      @command = AppCmd::APP_LIST
      @data = data
    end
    
    def to_s
      return "App list:\n #{@data}"
    end
    
  end

end
