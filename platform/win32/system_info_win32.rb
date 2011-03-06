require "win32ole"

class SystemInfoWin32
  
  @@_drive_letters = nil
  
  def SystemInfoWin32.drive_letters
    if not @@_drive_letters
      @@_drive_letters = []
      wmi = WIN32OLE.connect("winmgmts://")
      wmi.ExecQuery("Select * From Win32_LogicalDisk").each {|d| @@_drive_letters << d.name}
    end
    return @@_drive_letters
  end
  
end

