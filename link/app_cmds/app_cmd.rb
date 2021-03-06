require "rdcl/link/cmd_base.rb"

module RDCL

  class AppCmd < CmdBase
    
    PROGRESS = 1
    CONNECT = 2
    CONNECTED = 3
    DISCONNECT = 4
    DISCONNECTED = 5
    START_KEYBOARD_PASSTHROUGH = 6
    GET_APP_LIST = 7
    NEWTON_NAME = 8
    APP_LIST = 9
    INSTALL_PACKAGE = 10
    GET_DEFAULT_STORE = 11
    DEFAULT_STORE = 12
    GET_STORE_NAMES = 13
    STORE_NAMES = 14
    QUERY_SOUP = 15
    SET_CURRENT_SOUP = 16
    SOUP_SELECTED = 17
    SET_CURRENT_STORE = 18
    STORE_SELECTED = 19
    GET_SOUP_NAMES = 20
    SOUP_NAMES = 21
    PACKAGE_INSTALLED = 22
    QUERY_CURSOR = 23
    CURSOR_FREE = 24
    CURSOR_FREED = 25
    CURSOR_NEXT = 26
    CURSOR_ENTRY = 27
    DELETE_ENTRIES = 28
    ENTRIES_DELETED = 29
    ADD_ENTRY = 30
    ENTRY_ADDED = 31
    GET_PACKAGE_LIST = 32
    PACKAGE_LIST = 33
    SEND_SOUP = 34
    SOUP_SENT = 35

    def to_s
      return "AppCmd: #{@command}"
    end

  end

end
