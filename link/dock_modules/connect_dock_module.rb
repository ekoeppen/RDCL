require "rdcl/link/dock_modules/dock_module.rb"
require "rdcl/link/app_cmds/app_cmd_progress.rb"
require "rdcl/link/app_cmds/app_cmd_newton_name.rb"
require "rdcl/platform/platform.rb"

module RDCL

  class ConnectDockModule < DockModule
    
    def initialize(dock_link, timeout = nil)
      super(dock_link, :connect_dock_module)
      
      @log_transitions = nil

      @timeout = timeout
      init_automaton :idle, [:idle]
      transition do |state, action|
        new_state = case [state, action]
        when [:idle, DockCmd::REQUEST_TO_DOCK] then initiate_docking; :initiate_docking
        when [:initiate_docking, DockCmd::NEWTON_NAME] then desktop_info; :deskop_info
        when [:deskop_info, DockCmd::NEWTON_INFO] then save_challenge; which_icons; :which_icons
        when [:which_icons, DockCmd::RESULT] then set_timeout; :set_timeout
        when [:set_timeout, DockCmd::PASSWORD] then password; dock_connected; :connected
        when [:password, DockCmd::RESULT] then :idle
        when [:connected, DockCmd::DISCONNECT] then dock_disconnected; :idle
        when [:connected, AppCmd::DISCONNECT] then app_disconnect; :idle
        when [:idle, AppCmd::DISCONNECT] then app_disconnect; :idle
        else nil
        end

        new_state = state if not new_state
        new_state
      end
    end

    def initiate_docking
      dock_write(DockCmdInitiateDocking.new(DockCmdInitiateDocking::SESSION_NONE))
      app_receive(AppCmdProgress.new(0))
    end

    def desktop_info
      if Platform.isWindows? and not Platform.isCygwin?
        type = DockCmdDesktopInfo::DESKTOP_TYPE_WIN
      else
        type = DockCmdDesktopInfo::DESKTOP_TYPE_MAC
      end
      dock_write(DockCmdDesktopInfo.new(type))
      app_receive(AppCmdNewtonName.new(@command.name, @command.version_info))
      app_receive(AppCmdProgress.new(20))
    end

    def save_challenge
      @newton_challenge = [@command.key0, @command.key1]
      des = DES.new
      des.set_newton_key(DES::NEWTON_DEFAULT_KEY)
      data = (@newton_challenge[0] << 32) + @newton_challenge[1]
      dec = des.encrypt_block(data)
      @newton_challenge_encrypted = [(dec & 0xffffffff00000000) >> 32, dec & 0xffffffff]
    end

    def which_icons
      dock_write(DockCmdWhichIcons.new)
      app_receive(AppCmdProgress.new(40))
    end

    def set_timeout
      if @timeout
        c = DockCmdSetTimeout.new
        c.set(@timeout)
      else
        c = DockCmdResult.new
      end
      dock_write(c)
      app_receive(AppCmdProgress.new(60))
    end

    def password
      c = DockCmdPassword.new
      c.set(@newton_challenge_encrypted[0], @newton_challenge_encrypted[1])
      dock_write(c)
      app_receive(AppCmdProgress.new(80))
    end

    def hello
      dock_write(DockCmdHello.new)
    end

    def dock_connected
      app_receive(AppCmdProgress.new(100))
      app_receive(AppCmd.new(AppCmd::CONNECTED))
    end

    def dock_disconnected
      app_receive(AppCmd.new(AppCmd::DISCONNECTED))
    end
    
    def app_disconnect
      dock_write(DockCmdDisconnect.new)
      sleep 1
      app_receive(AppCmd.new(AppCmd::DISCONNECTED))
    end

  end
  
end
