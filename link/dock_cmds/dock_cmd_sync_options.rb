require "rdcl/link/dock_cmds/dock_cmd.rb"

module RDCL

  class DockCmdSyncOptions < DockCmd

    attr_accessor :packages
    attr_accessor :sync_all
    attr_accessor :stores
    attr_accessor :options_length
    
    def initialize
      @command = DockCmd::SYNC_OPTIONS
      @packages = nil
      @sync_all = nil
      @stores = []
    end
    
    def to_s
      return "Sync options:\n  Sync packages: #{@packages}\n  Sync all: #{@sync_all}\n  Options length: #{@options_length}"
    end
    
    def from_binary(b)
      super(b)
      c = b.unpack("A4A4A4N N")
      @options_length = c[3]
    end

  end

end
