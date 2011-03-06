require "rdcl/link/app_cmds/app_cmd.rb"

module RDCL

  class AppCmdProgress < AppCmd

    attr_accessor :percent

    def initialize(percent = 0)
      @command = AppCmd::PROGRESS
      @percent = percent
    end
    
    def to_s
      return "Progress: #{@percent}%"
    end
    
  end

end
