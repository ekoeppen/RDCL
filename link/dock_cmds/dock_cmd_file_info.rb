require "rdcl/link/dock_cmds/dock_cmd.rb"

module RDCL

  class DockCmdFileInfo < DockCmd

    def initialize(file_name)
      @command = DockCmd::FILE_INFO

      file = File.new(file_name)
      stat = file.stat()

      info = NSFrame.new([
        [NSSymbol.new("kind"), NSString.new("File")],
        [NSSymbol.new("size"), NSInteger.new(stat.size)],
        [NSSymbol.new("created"), NSInteger.new(stat.ctime.to_i / 60 + 34714059)],
        [NSSymbol.new("modified"), NSInteger.new(stat.mtime.to_i / 60 + 34714059)],
#        [NSSymbol.new("created"), NSInteger.new(0)],
#        [NSSymbol.new("modified"), NSInteger.new(0)],
        [NSSymbol.new("path"), NSString.new(file.path)],
        ])

      @data = 2.chr + info.to_nsof
    end

  end

end
