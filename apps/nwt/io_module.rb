require "fileutils"

module IoModule
  
  attr_accessor :store_entries
  attr_accessor :newton_entries
  attr_accessor :io_inbox
  attr_accessor :io_outbox
  attr_accessor :io_sent
  
  def io_get_opts
    return [
      ["--io-root", GetoptLong::REQUIRED_ARGUMENT],
      ["--io-sync", "-y", GetoptLong::NO_ARGUMENT],
      ["--io-get-all", GetoptLong::NO_ARGUMENT],
      ["--io-keep", GetoptLong::NO_ARGUMENT],
    ]
  end
  
  def io_handle_opts(opt, arg)
    case opt
    when "--io-root" then @settings["io_root"] = arg
    when "--io-sync" then @cmd = "io"
    when "--io-get-all" then @flags[:io_get_all] = true
    when "--io-keep" then @flags[:io_keep] = true
    end
  end
  
  def io_initialize
    @io_inbox = @settings["io_root"] + "/In/"
    @io_outbox = @settings["io_root"] + "/Out/"
    @io_sent = @settings["io_root"] + "/Sent/"
    if not File.exists?(@io_inbox) then FileUtils.mkdir_p(@io_inbox) end
    if not File.exists?(@io_outbox) then FileUtils.mkdir_p(@io_outbox) end
    if not File.exists?(@io_sent) then FileUtils.mkdir_p(@io_sent) end
    @newton_entries = Dir.glob(@io_outbox + "*")
  end
  
  def io_transition(state, action)
    case [state, action.command]
    when [:idle, AppCmd::CONNECTED] then
      @dock.receive(AppCmd.new(AppCmd::GET_STORE_NAMES))
      state = :io_read
    when [:io_read, AppCmd::STORE_NAMES] then
      @newton_stores = action.data.to_ruby
      @current_store = 0
      @dock.receive(AppCmd.new(AppCmd::SET_CURRENT_STORE, @newton_stores[@current_store]))
    when [:io_read, AppCmd::STORE_SELECTED] then
      @dock.receive(AppCmd.new(AppCmd::SET_CURRENT_SOUP, "OutBox"))
    when [:io_read, AppCmd::SOUP_SELECTED] then
      @store_entries = []
      @dock.receive(AppCmd.new(AppCmd::QUERY_SOUP, {
          :querySpec => {
          }
        }))
    when [:io_read, AppCmd::QUERY_CURSOR] then
      @cursor = action.data
      @dock.receive(AppCmd.new(AppCmd::CURSOR_ENTRY, @cursor))
    when [:io_read, AppCmd::CURSOR_ENTRY] then
      e = action.data[:translated].to_ruby
      if not e
        @dock.receive(AppCmd.new(AppCmd::CURSOR_FREE, @cursor))
      else
        @store_entries << e
        io_handle_entry(e)
        @dock.receive(AppCmd.new(AppCmd::CURSOR_NEXT, @cursor))
      end
    when [:io_read, AppCmd::CURSOR_FREED] then
      ids = []
      @store_entries.each do |e|
        if @flags[:io_get_all] or e[:category] == :"DockTransport:40hz" then ids << e[:_uniqueID] end
      end
      if not @flags[:io_keep]
        @dock.receive(AppCmd.new(AppCmd::DELETE_ENTRIES, ids))
      else
        state = io_next_store
      end
    when [:io_read, AppCmd::ENTRIES_DELETED]
      state = io_next_store
    when [:io_write, AppCmd::STORE_SELECTED] then
      @dock.receive(AppCmd.new(AppCmd::SET_CURRENT_SOUP, "InBox"))
    when [:io_write, AppCmd::SOUP_SELECTED] then
      e = {
        :class => :ioItem,
        :xlabels => [:_unfiled, :_new],
        :currentFormat => :textFormat,
        :category => :"DockTransport:40Hz",
        :timestamp => ((Time.now - Time.utc(1904, 1,1)) / 60).to_i,
        :labels => [],
        :state => :received,
        :body => {
          :class => :text,
          :title => "Entry",
          :data => "Entry"
        }
      }
      @dock.receive(AppCmd.new(AppCmd::ADD_ENTRY, e))
    when [:io_write, AppCmd::ENTRY_ADDED] then
      @dock.receive(AppCmd.new(AppCmd::DISCONNECT))
      return :idle
    end
    return state
  end
  
  def io_next_store
    @current_store += 1
    if @current_store < @newton_stores.length
      @dock.receive(AppCmd.new(AppCmd::SET_CURRENT_STORE, @newton_stores[@current_store]))
      return :io_read
    else
      if @newton_entries.length == 0
        @dock.receive(AppCmd.new(AppCmd::DISCONNECT))
        return :idle
      else
        @dock.receive(AppCmd.new(AppCmd::SET_CURRENT_STORE, :default))
        Dir.chdir(@io_outbox)
        return :io_write
      end
    end
  end
  
  def io_handle_entry(e)
    if @flags[:verbose] then log "Entry:\n#{e.to_yaml}" end

    body = e[:body]
    basename = @io_inbox + @newton_stores[@current_store][:signature].to_s +
      "-" + e[:_uniqueID].to_s

    if @flags[:convert]
      suffix = "txt"
      if body[:"IC/VC:40hz"] and body[:"IC/VC:40hz"][:suffix] then suffix = body[:"IC/VC:40hz"][:suffix] end
      if body[:title] then basename = @io_inbox + body[:title] end

      File.open(basename + "." + suffix, "wb") do |f|
        f.write(body[:text])
      end
    else
      File.open(basename + ".nsof", "wb") do |f|
        f.write(NSOF::NSOFVERSION.chr + body.to_nsof)
      end
    end
  end
  
  def io_usage
      return <<EOT
  Newton Inbox/Outbox sync:
    --io-sync, -y
      Synchronizes the Newton Inbox and Outbox. This option reads all
      entries in the Newton's Outbox and stores them in the Out directory
      of the specified root directory, and stores all data in the In
      directory in the Newton's Inbox.

      By default, all entries in the Newton's Outbox are deleted, and
      only the items which have been sent with the Dock transport on the
      Newton are read. This can be changed using the --io-keep and
      --io-get-all switches.

    --io-root <dir>
      <dir> is the base directory which is used for the data exchange. Under
      this directory, the directories In, Out and Sent are used to exchange
      the data. This switch overrides the io_root setting in the settings
      file.

    --io-get-all
      Reads all entries in the Newton's Outbox regardless of the transport
      which has been used to send them.

    --io-keep
      Does not delete the entries in the Newton's Outbox after reading them.

EOT
    end

end
