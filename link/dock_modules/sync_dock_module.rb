require "rdcl/link/dock_modules/dock_module.rb"

module RDCL

  class SyncDockModule < DockModule
    
    def initialize(dock_link)
      super(dock_link)
      
      @log_transitions = nil

      @timeout = timeout
      init_automaton :idle, [:idle]
      transition do |s, a|
        new_state = case [s, a]

        when [:connected, DockCmd::REQUEST_TO_SYNC] then start_sync; :get_sync_opts
        when [:get_sync_opts, DockCmd::SYNC_OPTIONS] then puts(@command.to_s); :idle

        else nil

        new_state = s if not new_state
        new_state
      end
    end

    def start_sync
      dock_write(DockCmdGetSyncOptions.new)
    end

  end
  
end