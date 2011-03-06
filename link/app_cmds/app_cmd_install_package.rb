require "rdcl/link/app_cmds/app_cmd.rb"

module RDCL

  class AppCmdInstallPackage < AppCmd

    attr_accessor :file_name

    def initialize(file_name)
      @file_name = file_name
      @command = AppCmd::INSTALL_PACKAGE
      f = File.new(file_name, "rb")
      @data = f.sysread(f.stat.size)
      f.close
    end
    
    def to_s
      return "Get app list"
    end
    
  end

end
