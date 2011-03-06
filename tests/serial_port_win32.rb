require 'Win32API'
require 'thread'

class SerialPortWin32
  
  # Windows constants.
  GENERIC_READ = 0x80000000
  GENERIC_WRITE = 0x40000000
  OPEN_EXISTING = 0x00000003
  FILE_FLAG_OVERLAPPED = 0x40000000
  NULL = 0x00000000
  EV_RXCHAR = 0x0001
  
  # Windows system error codes
  ERROR_IO_PENDING = 997
  
  def initialize
    # Create objects to access Windows file system API.
    @CreateFile = Win32API.new("Kernel32", "CreateFile", "PLLLLLL", "L")
    @CloseHandle = Win32API.new("Kernel32","CloseHandle", "L", "N")
    @ReadFile = Win32API.new('Kernel32','ReadFile','LPLPP','I')
    @WriteFile = Win32API.new('Kernel32','WriteFile','LPLPP','I')
    @SetCommState = Win32API.new("Kernel32","SetCommState","LP","N")
    @SetCommTimeouts = Win32API.new("Kernel32","SetCommTimeouts","LP","N")
    @GetLastError = Win32API.new("Kernel32","GetLastError", "V", "N")
    @GetCommState = Win32API.new("Kernel32","GetCommState", "LP", "N")
    @WaitCommEvent = Win32API.new("Kernel32","WaitCommEvent", "LPP", "I")
    @SetCommMask = Win32API.new("Kernel32","SetCommMask", "LL", "I")
    
  end
  
  def open(port, speed = nil)
    @port = port
    # Get a file handle
    @hFile = @CreateFile.Call(@port, GENERIC_READ|GENERIC_WRITE, 0,NULL,OPEN_EXISTING,0,NULL)
    commTimeouts = [0,10,0,0,0].pack("L*")
    @SetCommTimeouts.Call(@hFile, commTimeouts)
  end

  def read(count)
    r = ""
    begin
      inbuf="\x00"
      numread="\x00"*4
      @ReadFile.Call(@hFile,inbuf,1,numread,NULL)
      n = numread.unpack("L")[0]
      if n > 0
        r += inbuf
      end
    end while r.length < count
    return r
  end

  def write(data)
    @WriteFile.Call(@hFile,data,data.length,NULL,NULL)
  end

  def close
    @CloseHandle.Call(@hFile)
  end

end

if __FILE__ == $0
  puts $0
end