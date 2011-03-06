module InstallModule

  def install_usage
    return <<EOT
  Package management:
    --install, -i <file name>
      Installs the package file <file name>. Does not install the package if it
      exists already on the Newton.

    --uninstall, -u <package>
      Removes the named package from the Newton
  
EOT
  end
  
  def install_get_opts
    return [
      ["--install", "-i", GetoptLong::REQUIRED_ARGUMENT],
      ["--uninstall", "-u", GetoptLong::REQUIRED_ARGUMENT],
    ]
  end
  
  def install_handle_opts(opt, arg)
    case opt
    when "--install" then @cmd = "install"; @arg = String.new(arg);
    when "--uninstall" then @cmd = "uninstall"; @arg = String.new(arg);
    end
  end
  
  def install_transition(state, action)
    case action.command
    when AppCmd::CONNECTED then
      log "Installing #{@arg}."
      @dock.receive(AppCmdInstallPackage.new(@arg))
    when AppCmd::PACKAGE_INSTALLED then
      @dock.receive(AppCmd.new(AppCmd::DISCONNECT))
    end
    return state
  end
  
  def uninstall_transition(state, action)
    return state
  end
  
end
