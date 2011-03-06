require "rdcl/link/dock_cmds/dock_cmd.rb"
require "rdcl/nsof/ns_plainarray.rb"
require "rdcl/nsof/ns_frame.rb"
require "rdcl/nsof/ns_integer.rb"
require "rdcl/nsof/ns_string.rb"
require "rdcl/nsof/ns_symbol.rb"

module RDCL

  class DockCmdPath < DockCmd

    def initialize(path)
      @command = DockCmd::PATH
      
      path_array = NSPlainArray.new([])

      if not Platform.isWindows?
        path_array.value << NSFrame.new([
          [NSSymbol.new("name"), NSString.new('/')],
          [NSSymbol.new("type"), NSInteger.new(2)],
          ])
      end

      path.split("/").each do |folder_name|
        if folder_name != ""
          path_array.value << NSFrame.new([
            [NSSymbol.new("name"), NSString.new(folder_name)],
            [NSSymbol.new("type"), NSInteger.new(2)],
            ])
        end
      end
      
      @data = 2.chr + path_array.to_nsof
    end
    
  end

end
