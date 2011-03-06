require "rdcl/link/dock_cmds/dock_cmd.rb"
require "rdcl/nsof/ns_object.rb"
require "rdcl/nsof/ns_symbol.rb"
require "rdcl/nsof/ns_string.rb"
require "rdcl/nsof/ns_integer.rb"
require "rdcl/nsof/ns_array.rb"
require "rdcl/nsof/ns_plainarray.rb"
require "rdcl/nsof/ns_frame.rb"

module RDCL

  class DockCmdDesktopInfo < DockCmd

    attr_accessor :session_type
    attr_accessor :desktop_type
    attr_accessor :selective_sync
    attr_accessor :desktop_apps
    attr_accessor :key0
    attr_accessor :key1
    
    DESKTOP_TYPE_MAC = 0
    DESKTOP_TYPE_WIN = 1
    PROTOCOL_VERSION = 10
    
    def initialize(desktop_type = DESKTOP_TYPE_MAC,
      session_type = DockCmdInitiateDocking::SESSION_SETTING_UP,
      selective_sync = 1, desktop_apps = nil)

      @command = DockCmd::DESKTOP_INFO
      @session_type     = session_type
      @desktop_type     = desktop_type
      @selective_sync   = selective_sync
      @desktop_apps     = desktop_apps

      @desktop_apps = NSPlainArray.new([
        NSFrame.new([
          [NSSymbol.new("id"), NSInteger.new(2)],
          [NSSymbol.new("name"), NSString.new("Newton Connection Utilities")],
          [NSSymbol.new("version"), NSInteger.new(1)]
        ])
      ])

      @key0 = 0x6423ef02
      @key1 = 0xfbcdc5a5
    end
    
    def to_binary
      payload = [
        PROTOCOL_VERSION,
        @desktop_type,
        @key0, @key1,
        @session_type,
        @selective_sync].pack("NNNNNN")
      payload += 2.chr + @desktop_apps.to_nsof
      padding = 4 - payload.length % 4
      padding = 0 if padding == 4
      return "newtdock" + @command + [payload.length].pack("N") + payload + 0.chr * padding
    end
    
  end

end
