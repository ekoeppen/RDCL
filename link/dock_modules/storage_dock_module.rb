require "rdcl/link/dock_modules/dock_module.rb"
require "rdcl/link/app_cmds/app_cmd_default_store.rb"
require "rdcl/link/app_cmds/app_cmd_store_names.rb"
require "rdcl/link/app_cmds/app_cmd_soup_names.rb"

module RDCL

  class StorageDockModule < DockModule
    
    attr_accessor :cursor
    
    def initialize(dock_link)
      super(dock_link, :storage_list_dock_module)
      
      @log_transitions = nil

      init_automaton :idle, [:idle]
      transition do |s, a|
        new_state = case [s, a]
        when [:idle, AppCmd::GET_DEFAULT_STORE] then start_get_default_store; :get_default_store
        when [:get_default_store, DockCmd::DEFAULT_STORE] then finish_get_default_store; :idle

        when [:idle, AppCmd::GET_STORE_NAMES] then start_get_store_names; :get_store_names
        when [:get_store_names, DockCmd::STORE_NAMES] then finish_get_store_names; :idle
        
        when [:idle, AppCmd::QUERY_SOUP] then query_soup; :soup_query
        when [:soup_query, DockCmd::RESULT] then set_cursor_id; :idle
        when [:soup_query, DockCmd::LONG_DATA] then set_cursor_id; :idle
          
        when [:idle, AppCmd::CURSOR_FREE] then cursor_free; :cursor_free
        when [:cursor_free, DockCmd::RESULT] then finish_cursor_free; :idle

        when [:idle, AppCmd::CURSOR_NEXT] then cursor_next; :cursor_entry
        when [:idle, AppCmd::CURSOR_ENTRY] then cursor_entry; :cursor_entry
        when [:cursor_entry, DockCmd::ENTRY] then finish_cursor_entry; :idle
        when [:cursor_entry, DockCmd::REF_RESULT] then finish_cursor_entry; :idle

        when [:idle, AppCmd::SET_CURRENT_STORE] then set_current_store; :set_current_store
        when [:set_current_store, DockCmd::RESULT] then store_selected; :idle

        when [:idle, AppCmd::SET_CURRENT_SOUP] then set_current_soup; :set_current_soup
        when [:set_current_soup, DockCmd::RESULT] then soup_selected; :idle

        when [:idle, AppCmd::GET_SOUP_NAMES] then get_soup_names; :get_soup_names
        when [:get_soup_names, DockCmd::SOUP_NAMES] then finish_get_soup_names; :idle

        when [:idle, AppCmd::DELETE_ENTRIES] then delete_entries; :delete_entries
        when [:delete_entries, DockCmd::RESULT] then entries_deleted; :idle

        when [:idle, AppCmd::ADD_ENTRY] then add_entry; :add_entry
        when [:add_entry, DockCmd::ADDED_ID] then entry_added; :idle
          
        when [:idle, AppCmd::SEND_SOUP] then send_soup; :send_soup
        when [:send_soup, DockCmd::ENTRY] then soup_entry; :send_soup
        when [:send_soup, DockCmd::BACKUP_SOUP_DONE] then finish_send_soup; :idle

        when [:idle, DockCmd::OPERATION_CANCELED2] then dock_write(DockCmdOpCanceledAck.new); :idle

        else nil
        end

        new_state = s if not new_state
        new_state
      end
    end

    def start_get_default_store
      dock_write(DockCmdGetDefaultStore.new)
    end

    def finish_get_default_store
      @command.data.slice!(0)
      obj = NSObjectFactory.new.from_nsof_factory(@command.data)
      app_receive(AppCmdDefaultStore.new(obj))
    end

    def start_get_store_names
      dock_write(DockCmdGetStoreNames.new)
    end

    def finish_get_store_names
      @command.data.slice!(0)
      obj = NSObjectFactory.new.from_nsof_factory(@command.data)
      app_receive(AppCmdStoreNames.new(obj))
    end
    
    def query_soup
      b = 2.chr + @command.data.to_nsof
      dock_write(DockCmd.new(DockCmd::QUERY, b))
      @cursor = nil
    end
    
    def set_cursor_id
      @cursor = @command.data.unpack("N")[0]
      if @cursor >= 0
        app_receive(AppCmd.new(AppCmd::QUERY_CURSOR, @cursor))
      else
        puts "Error #{@cursor}"
      end
    end

    def set_current_soup
      dock_write(DockCmdSetCurrentSoup.new(@command.data))
    end
    
    def soup_selected
      app_receive(AppCmd.new(AppCmd::SOUP_SELECTED, @command.result))
    end

    def set_current_store
      if @command.data == :default
        dock_write(DockCmd.new(DockCmd::SET_STORE_TO_DEFAULT))
      else
        b = NSFrame.new([
          [NSSymbol.new("name"), NSString.new(@command.data[:name])],
          [NSSymbol.new("kind"), NSString.new(@command.data[:kind])],
          [NSSymbol.new("signature"), NSInteger.new(@command.data[:signature])],
          ])
        dock_write(DockCmd.new(DockCmd::SET_CURRENT_STORE, NSOF::NSOFVERSION.chr + b.to_nsof))
      end
    end
    
    def store_selected
      app_receive(AppCmd.new(AppCmd::STORE_SELECTED, @command.result))
    end
    
    def get_soup_names
      dock_write(DockCmd.new(DockCmd::GET_SOUP_NAMES))
    end

    def finish_get_soup_names
      @command.data.slice!(0)
      obj = NSObjectFactory.new.from_nsof_factory(@command.data)
      app_receive(AppCmdSoupNames.new(obj))
    end
    
    def cursor_free
      dock_write(DockCmd.new(DockCmd::CURSOR_FREE, [@command.data].pack("N")))
    end
    
    def finish_cursor_free
      app_receive(AppCmd.new(AppCmd::CURSOR_FREED, @command.result))
    end
    
    def cursor_next
      dock_write(DockCmd.new(DockCmd::CURSOR_NEXT, [@command.data].pack("N")))
    end
    
    def cursor_entry
      dock_write(DockCmd.new(DockCmd::CURSOR_ENTRY, [@command.data].pack("N")))
    end
    
    def send_entry_to_app
      File.open("entry.nsof", "wb+") { |f| f.write(@command.data) }
      data = {:nsof => String.new(@command.data)}
      @command.data.slice!(0)
      data[:translated] = NSObjectFactory.new.from_nsof_factory(@command.data)
      app_receive(AppCmd.new(AppCmd::CURSOR_ENTRY, data))
    end
    
    def finish_cursor_entry
      send_entry_to_app
    end
    
    def delete_entries
      f = "N" * @command.data.length
      b = [@command.data.length].pack("N") + @command.data.pack(f)
      dock_write(DockCmd.new(DockCmd::DELETE_ENTRIES, b))
    end
    
    def entries_deleted
      app_receive(AppCmd.new(AppCmd::ENTRIES_DELETED))
    end
    
    def add_entry
      dock_write(DockCmd.new(DockCmd::ADD_ENTRY, NSOF::NSOFVERSION.chr + @command.data.to_nsof))
    end
    
    def entry_added
      app_receive(AppCmd.new(AppCmd::ENTRY_ADDED))
    end
    
    def send_soup
      dock_write(DockCmd.new(DockCmd::SEND_SOUP))
    end
    
    def finish_send_soup
      app_receive(AppCmd.new(AppCmd::SOUP_SENT))
    end
    
    def soup_entry
      send_entry_to_app
    end
    
  end
  
end
