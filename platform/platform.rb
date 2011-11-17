require 'rbconfig'
require "rdcl/platform/win32/system_info_win32" if RbConfig::CONFIG["arch"] =~ /win32/ or RbConfig::CONFIG["arch"] =~ /mingw32/  

class Platform
  
  def Platform.isWindows?
    Platform.isMSWin32? ||
    Platform.isMingw32? ||
    Platform.isBCCWin32?
  end
  
  def Platform.isPosix?
    not Platform.isWindows?
  end
  
  def Platform.isCygwin?
    RbConfig::CONFIG["arch"] =~ /cygwin/
  end
  
  def Platform.isMingw32?
    RbConfig::CONFIG["arch"] =~ /mingw32/
  end
  
  def Platform.isMSWin32?
    RbConfig::CONFIG["arch"] =~ /mswin32/
  end

  def Platform.isBCCWin32?
    RbConfig::CONFIG["arch"] =~ /bccwin32/
  end
  
  def Platform.settings_file
    if Platform.isWindows?
      return ENV['HOMEDRIVE'] + ENV['HOMEPATH'] + "/Local Settings/rdcl.yaml"
    else
      return ENV['HOME'] + "/.rdcl.yaml"
    end
  end
  
  def Platform.check_settings
    r = nil
    if Platform.isWindows?
      SystemInfoWin32.drive_letters
      if not ENV['HOMEDRIVE']
        puts "Cannot read settings file, HOMEDRIVE environment variable not set."
      elsif not ENV['HOMEPATH']
        puts "Cannot read settings file, HOMEPATH environment variable not set."
      elsif not File.exist?(Platform.settings_file)
        puts "Could not find settings file #{Platform.settings_file}."
      else
        r = true
      end
    else
      if not ENV['HOME']
        puts "Cannot read settings file, HOMEDRIVE environment variable not set."
      elsif not File.exist?(Platform.settings_file)
        puts "Could not find settings file #{Platform.settings_file}."
      else
        r = true
      end
    end

    # Read settings file and check mandatory settings
    if r then
      r = YAML::load(File.new(Platform.settings_file))
      if not r["io_root"]
        puts "io_root setting not defined in #{Platform.settings_file}"
        r = nil
      end
    end
    return r
  end
  
  def Platform.write_settings(settings)
    File.open(Platform.settings_file, 'w') { |f| f.write(settings) }
  end
  
end
