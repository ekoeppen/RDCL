require "rdcl/link/dock_cmds/dock_cmd.rb"

module RDCL

  class DockCmdFilesAndFolders < DockCmd

    def initialize(path, show_hidden_files = false)
      @command = DockCmd::FILES_AND_FOLDERS

      file_array = NSPlainArray.new([])

      Dir.foreach(path).each do |file_name|
        if file_name != "." and file_name != ".." and (show_hidden_files or not show_hidden_files and file_name[0..0] != ".")
          file_array.value << NSFrame.new([
            [NSSymbol.new("name"), NSString.new(file_name)],
            [NSSymbol.new("type"), NSInteger.new(File.directory?(path + '/' + file_name) ? 2 : 1)],
            ])
        end
      end

      @data = 2.chr + file_array.to_nsof
    end
    
  end

end
