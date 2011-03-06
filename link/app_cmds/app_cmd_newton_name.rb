require "rdcl/link/app_cmds/app_cmd.rb"

module RDCL

  class AppCmdNewtonName < AppCmd

    attr_accessor :version_info
    attr_accessor :name

    def initialize(name, version_info)
      @command = AppCmd::NEWTON_NAME
      @version_info = version_info
      @name = name
    end
    
    def to_s
      return @name
    end
    
  end

end
