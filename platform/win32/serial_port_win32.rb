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
  MAXDWORD = 4294967295
  
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
  
  def open(port, speed = nil, blocking = nil)
=begin
  DWORD DCBlength;
  DWORD BaudRate;
  DWORD fBinary  :1;
  DWORD fParity  :1;
  DWORD fOutxCtsFlow  :1;
  DWORD fOutxDsrFlow  :1;
  DWORD fDtrControl  :2;
  DWORD fDsrSensitivity  :1;
  DWORD fTXContinueOnXoff  :1;
  DWORD fOutX  :1;
  DWORD fInX  :1;
  DWORD fErrorChar  :1;
  DWORD fNull  :1;
  DWORD fRtsControl  :2;
  DWORD fAbortOnError  :1;
  DWORD fDummy2  :17;
  WORD wReserved;
  WORD XonLim;
  WORD XoffLim;
  BYTE ByteSize;
  BYTE Parity;
  BYTE StopBits;
  char XonChar;
  char XoffChar;
  char ErrorChar;
  char EofChar;
  char EvtChar;
  WORD wReserved1;
=end
    @port = port
    
    s = 
      "L" + # DWORD DCBlength;
      "L" + # DWORD BaudRate;
      
      "C" +
#      "B1" + # DWORD fBinary  :1;
#      "B1" + # DWORD fParity  :1;
#      "B1" + # DWORD fOutxCtsFlow  :1;
#      "B1" + # DWORD fOutxDsrFlow  :1;
#      "B2" + # DWORD fDtrControl  :2;
#      "B1" + # DWORD fDsrSensitivity  :1;
#      "B1" + # DWORD fTXContinueOnXoff  :1;
 
      "C" +
      "C" +
      "C" +
#      "B1" + # DWORD fOutX  :1;
#      "B1" + # DWORD fInX  :1;
#      "B1" + # DWORD fErrorChar  :1;
#      "B1" + # DWORD fNull  :1;
#      "B2" + # DWORD fRtsControl  :2;
#      "B1" + # DWORD fAbortOnError  :1;
#      "B17" + # DWORD fDummy2  :17;
      
      "S" + # WORD wReserved;
      "S" + # WORD XonLim;
      "S" + # WORD XoffLim;
      "C" + # BYTE ByteSize;
      "C" + # BYTE Parity;
      "C" + # BYTE StopBits;
      "C" + # char XonChar;
      "C" + # char XoffChar;
      "C" + # char ErrorChar;
      "C" + # char EofChar;
      "C" + # char EvtChar;
      "S"   # WORD wReserved1;

    # Get a file handle
    @hFile = @CreateFile.Call(@port, GENERIC_READ|GENERIC_WRITE, 0,NULL,OPEN_EXISTING,0,NULL)

    if blocking then
      commTimeouts = [MAXDWORD,MAXDWORD,1000000,0,0].pack("L*")
    else
      commTimeouts = [0,10,0,0,0].pack("L*")
    end
    @SetCommTimeouts.Call(@hFile, commTimeouts)

    if speed
      dcb_unpacked = [
        28,
        speed,
        17,
        16,
        0,
        0,
        0,
        2048,
        512,
        8,
        0,
        0,
        17,
        19,
        0,
        0,
        0,
        0     
      ]
      dcb = dcb_unpacked.pack(s)
      @SetCommState.Call(@hFile, dcb)
    end
  end

  def read(count)
    r = ""
    count = 1 if not count
    begin
      inbuf="\x00"
      numread="\x00"*4
      @ReadFile.Call(@hFile,inbuf,1,numread,NULL)
      n = numread.unpack("L")[0]
      if n > 0
        r += inbuf
      else
        sleep(0.1)
      end
    end while r.length < count
    return r
  end

  def write(data)
    numwrite="\x00"*4
    @WriteFile.Call(@hFile,data,data.length,numwrite,NULL)
  end

  def close
    @CloseHandle.Call(@hFile)
  end

end

if __FILE__ == $0
  puts $0
end