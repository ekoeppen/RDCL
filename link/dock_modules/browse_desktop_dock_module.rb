require "rdcl/link/dock_modules/dock_module.rb"
require "rdcl/link/dock_cmds/dock_cmd_get_internal_store.rb"
require "rdcl/link/dock_cmds/dock_cmd_devices.rb"
require "rdcl/link/dock_cmds/dock_cmd_result.rb"

module RDCL

  class BrowseDesktopDockModule < DockModule
    
    attr_accessor :show_hidden_files
    
    def initialize(dock_link, show_hidden_files = false)
      super(dock_link, :browse_desktop_dock_module)
      
      @log_transitions = false
      @path = Dir.getwd
      @show_hidden_files = show_hidden_files

      init_automaton :idle, [:idle]
      transition do |state, action|
        new_state = case [state, action]
        when [:idle, DockCmd::REQUEST_TO_BROWSE] then confirm_browsing; :browsing
#        when [:idle, DockCmd::REQUEST_TO_BROWSE] then request_to_browse; :get_internal_store
        when [:get_internal_store, DockCmd::INTERNAL_STORE] then confirm_browsing; :browsing
          
        when [:browsing, DockCmd::GET_DEVICES] then send_devices; :browsing
        when [:browsing, DockCmd::GET_FILTERS] then send_filters; :browsing
        when [:browsing, DockCmd::GET_DEFAULT_PATH] then send_default_path; :browsing
        when [:browsing, DockCmd::GET_FILES_AND_FOLDERS] then send_files_and_folders; :browsing
        when [:browsing, DockCmd::SET_PATH] then set_path; :browsing
        when [:browsing, DockCmd::GET_FILE_INFO] then get_file_info; :browsing
        when [:browsing, DockCmd::SET_DRIVE] then set_drive; :browsing

        when [:browsing, DockCmd::RESULT] then puts @command.to_s; :browsing

        when [:get_internal_store, DockCmd::OPERATION_CANCELED2] then ack_cancel; :idle
        when [:get_internal_store, DockCmd::OPERATION_CANCELED] then ack_cancel; :idle
        when [:browsing, DockCmd::OPERATION_CANCELED2] then ack_cancel; :idle
        when [:browsing, DockCmd::OPERATION_CANCELED] then ack_cancel; :idle

        else nil
        end

        new_state = state if not new_state
        new_state
      end
    end

    def ack_cancel
      dock_write(DockCmdOpCanceledAck.new)
    end
    
    def request_to_browse
      dock_write(DockCmdGetInternalStore.new)
    end

    def confirm_browsing
      dock_write(DockCmdResult.new)
    end
    
    def send_default_path
      dock_write(DockCmdPath.new(@path))
    end

    def send_devices
      dock_write(DockCmdDevices.new())
    end

    def send_filters
      dock_write(DockCmdFilters.new())
    end

    def send_files_and_folders
      dock_write(DockCmdFilesAndFolders.new(@path, @show_hidden_files))
    end

    def set_path
      Dir.chdir(@command.path)
      dock_write(DockCmdFilesAndFolders.new(@command.path, @show_hidden_files))
    end

    def get_file_info
      dock_write(DockCmdFileInfo.new(@path + '/' + @command.name))
    end
    
    def set_drive
      Dir.chdir(@command.drive)
      @path = Dir.pwd
      dock_write(DockCmdPath.new(@path))
    end
  end
  
end