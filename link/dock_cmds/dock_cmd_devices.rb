require "rdcl/link/dock_cmds/dock_cmd.rb"
require "rdcl/platform/win32/system_info_win32" if Platform.isWindows?

module RDCL

  class DockCmdDevices < DockCmd
    
    def initialize
      @command = DockCmd::DEVICES
      
      device_array = NSPlainArray.new([])

      if Platform.isWindows?
        SystemInfoWin32.drive_letters.each do |drive|
          device_array.value << NSFrame.new([
            [NSSymbol.new("name"), NSString.new(drive)],
            [NSSymbol.new("disktype"), NSInteger.new(1)],
            ])
        end
      else
        device_array.value << NSFrame.new([
          [NSSymbol.new("name"), NSString.new("<root>")],
          [NSSymbol.new("disktype"), NSInteger.new(1)],
          ])
      end
      
      @data = 2.chr + device_array.to_nsof
    end
    
  end

end
