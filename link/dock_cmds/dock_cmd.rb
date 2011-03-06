require "rdcl/link/cmd_base.rb"

module RDCL

  class DockCmd < CmdBase

    # ----------------------------------------------------------------------
    LONG_DATA = "ldta"
    REF_RESULT = "ref "

    # ----------------------------------------------------------------------
    # Desktop -> Newton

    QUERY = "qury"
    CURSOR_GOTO_KEY = "goto"
    CURSOR_MAP = "cmap"
    CURSOR_ENTRY = "crsr"
    CURSOR_MOVE = "move"
    CURSOR_NEXT = "next"
    CURSOR_PREV = "prev"
    CURSOR_RESET = "rset"
    CURSOR_RESET_TO_END = "rend"
    CURSOR_COUNT_ENTRIES = "cnt "
    CURSOR_WHICH_END = "whch"
    CURSOR_FREE = "cfre"

    # ----------------------------------------------------------------------
    # Keyboard Passthrough

    # Desktop -> Newton

    KEYBOARD_CHAR = "kbdc"
    KEYBOARD_STRING = "kbds"

    # Desktop -> Newton or Newton -> Desktop
    START_KEYBOARD_PASSTHROUGH = "kybd"


    # ----------------------------------------------------------------------
    # Misc additions

    # Newton -> Desktop Commands

    DEFAULT_STORE = "dfst"
    APP_NAMES = "appn"
    IMPORT_PARAMETER_SLIP_RESULT = "islr"
    PACKAGE_INFO = "pinf"
    SET_BASE_ID = "base"
    BACKUP_IDS = "bids"
    BACKUP_SOUP_DONE = "bsdn"
    SOUP_NOT_DIRTY = "ndir"
    SYNCHRONIZE = "sync"
    CALL_RESULT = "cres"

    # Desktop -> Newton

    REMOVE_PACKAGE = "rmvp"
    RESULT_STRING = "ress"
    SOURCE_VERSION = "sver"
    ADD_ENTRY_WITH_UNIQUE_ID = "auni"
    GET_PACKAGE_INFO = "gpin"
    GET_DEFAULT_STORE = "gdfs"
    CREATE_DEFAULT_SOUP = "cdsp"
    GET_APP_NAMES = "gapp"
    REG_PROTOCOL_EXTENSION = "pext"
    REMOVE_PROTOCOL_EXTENSION = "rpex"
    SET_STORE_SIGNATURE = "ssig"
    SET_SOUP_SIGNATURE = "ssos"
    IMPORT_PARAMETERS_SLIP = "islp"
    GET_PASSWORD = "gpwd"
    SEND_SOUP = "snds"
    BACKUP_SOUP = "bksp"
    SET_STORE_NAME = "ssna"
    CALL_GLOBAL_FUNCTION = "cgfn"
    CALL_ROOT_METHOD = "crmd"
    SET_VBOCOMPRESSION = "cvbo"
    RESTORE_PATCH = "rpat"

    # Desktop -> Newton or Newton -> Desktop

    OPERATION_DONE = "opdn"
    OPERATION_CANCELED = "opcn"
    OP_CANCELED_ACK = "ocaa"
    REF_TEST = "rtst"
    UNKNOWN_COMMAND = "unkn"

    # ----------------------------------------------------------------------
    # Starting a session
    # 2.0 Newton supports a new set of protocols to enhance the connection
    # capabilities. However, since it"s desirable to also support package
    # downloading from NPI, NTK 1.0 and Connection 2.0 the ROMs will also
    # support the old protocol for downloading packages. To make this work
    # the 2.0 ROMs will pretend that they are talking the old protocol when
    # they send the Request_To_Dock message. If a new connection (or other
    #app) is on the other end the protocol will be negotiated up to the
    # current version. Only package loading is supported with the old
    # protocol.

    # Newton -> Desktop Commands

    # data = encrypted key
    PASSWORD = "pass"
    NEWTON_NAME = "name"
    NEWTON_INFO = "ninf"

    # Desktop -> Newton Commands

    # Ask Newton to start docking process
    INITIATE_DOCKING = "dock"
    # Info from the desktop (application & so on)
    DESKTOP_INFO = "dinf"
    # Optional to define which icons are shown
    WHICH_ICONS = "wicn"

    # ----------------------------------------------------------------------
    # Sync and Selective Sync

    # Newton -> Desktop Commands

    REQUEST_TO_SYNC = "ssyn"
    SYNC_OPTIONS = "sopt"

    # Desktop -> Newton Commands

    GET_SYNC_OPTIONS = "gsyn"
    SYNC_RESULTS = "sres"
    SET_STORE_GET_NAMES = "ssgn"
    SET_SOUP_GET_INFO = "ssgi"
    GET_CHANGED_INDEX = "cidx"
    GET_CHANGED_INFO = "cinf"

    # ----------------------------------------------------------------------
    # File browsing
    # File browsing will use the same protocol described above with the
    # following additions. For synchronize, the process is completely driven
    # from the desktop side. For file browsing/importing, however, the
    # process is driven from the Newton.

    # Newton -> Desktop Commands

    REQUEST_TO_BROWSE = "rtbr"
    # Windows only
    GET_DEVICES = "gdev"
    # Get the starting path
    GET_DEFAULT_PATH = "dpth"
    # Ask the desktop for files and folders
    GET_FILES_AND_FOLDERS = "gfil"
    SET_PATH = "spth"
    GET_FILE_INFO = "gfin"
    INTERNAL_STORE = "isto"
    RESOLVE_ALIAS = "rali"
    # Windows only
    GET_FILTERS = "gflt"
    # Windows only
    SET_FILTER = "sflt"
    # Windows only
    SET_DRIVE = "sdrv"

    # Desktop -> Newton

    # Windows only
    DEVICES = "devs"
    # Windows only
    FILTERS = "filt"
    PATH = "path"
    # Frame of info about files and folders
    FILES_AND_FOLDERS = "file"
    FILE_INFO = "finf"
    GET_INTERNAL_STORE = "gist"
    ALIAS_RESOLVED = "alir"

    # ----------------------------------------------------------------------
    # No data (?) undocumented.
    # Newton -> Dock
    # Réponse: ocaa
    OPERATION_CANCELED2 = "opca"

    # ----------------------------------------------------------------------
    # File importing
    # File importing uses the file browsing interface described above. After
    # the user taps the import button, the following commands are used.

    # Newton -> Desktop Commands

    IMPORT_FILE = "impt"
    SET_TRANSLATOR = "tran"

    # Desktop -> Newton

    TRANSLATOR_LIST = "trnl"
    IMPORTING = "dimp"
    SOUPS_CHANGED = "schg"
    SET_STORE_TO_DEFAULT = "sdef"

    # ----------------------------------------------------------------------
    # Package loading
    # Package loading uses the file browsing interface described above. After
    # the user taps the load package button, the following commands are used.

    # Newton -> Desktop Commands

    LOAD_PACKAGE_FILE = "lpfl"

    # ----------------------------------------------------------------------
    # Restore originated on Newton
    # Restore uses the file browsing interface described above. After the
    # user taps the restore button, the following commands are used.

    # Newton -> Desktop Commands

    RESTORE_FILE = "rsfl"
    GET_RESTORE_OPTIONS = "grop"
    RESTORE_ALL = "rall"

    # Desktop -> Newton or Newton -> Desktop

    RESTORE_OPTIONS = "ropt"
    RESTORE_PACKAGE = "rpkg"

    # ----------------------------------------------------------------------
    # Desktop Initiated Functions while connected
    # With the advent of the new protocol, the Newton and the desktop can be
    # connected, but with no command specified. A command can be requested by
    # the user on either the Newton or the Desktop. Commands requested by the
    # newton user are discussed above. This section describes the commands
    # sent from the Desktop to the Newton in response to a user request on
    # the desktop.

    # Desktop -> Newton Commands

    # Request_To_Sync = "ssyn"
    REQUEST_TO_RESTORE = "rrst"
    REQUEST_TO_INSTALL = "rins"

    # ----------------------------------------------------------------------
    # 1.0 Newton ROM Support

    # Newton -> Desktop Commands

    # Ask PC to start docking process
    REQUEST_TO_DOCK = "rtdk"
    # The name of the newton
    #Newton_Name = "name"
    # The current time on the Newton
    CURRENT_TIME = "time"
    # data = array of store names & signatures
    STORE_NAMES = "stor"
    # data = array of soup names & signatures
    SOUP_NAMES = "soup"
    # data = array of ids for the soup
    SOUP_IDS = "sids"
    # data = array of ids
    CHANGED_IDS = "cids"
    # data = command & result (error)
    RESULT = "dres"
    # data = the id of the added entry
    ADDED_ID = "adid"
    # data = entry being returned
    ENTRY = "entr"
    # data = list of package ids
    PACKAGE_IDLIST = "pids"
    # data = package
    PACKAGE = "apkg"
    # data = index description array
    INDEX_DESCRIPTION = "indx"
    # data = array of class, supperclass pairs 
    INHERITANCE = "dinh"
    # no data
    PATCHES = "patc"

    # Desktop -> Newton

    # data = session type
    #Initiate_Docking = "dock"
    # The time of the last sync
    LAST_SYNC_TIME = "stme"
    # no data
    GET_STORE_NAMES = "gsto"
    # no data
    GET_SOUP_NAMES = "gets"
    # data = store frane
    SET_CURRENT_STORE = "ssto"
    # data = soup name
    SET_CURRENT_SOUP = "ssou"
    # no data
    GET_SOUP_IDS = "gids"
    # no date
    GET_CHANGED_IDS = "gcid"
    # data = list of IDs
    DELETE_ENTRIES = "dele"
    # data = flattened entry
    ADD_ENTRY = "adde"
    # data = ID to return
    RETURN_ENTRY = "rete"
    # data = ID to return
    RETURN_CHANGED_ENTRY = "rcen"
    # no data
    EMPTY_SOUP = "esou"
    # no data
    DELETE_SOUP = "dsou"
    # data = package
    LOAD_PACKAGE = "lpkg"
    # no data
    GET_PACKAGE_IDS = "gpid"
    # no data
    BACKUP_PACKAGES = "bpkg"
    # no data
    DISCONNECT = "disc"
    # no data
    DELETE_ALL_PACKAGES = "dpkg"
    # no data
    GET_INDEX_DESCRIPTION = "gind"
    # data = name + index description
    CREATE_SOUP = "csop"
    # no data
    GET_INHERITANCE = "ginh"
    # data = # of seconds
    SET_TIMEOUT = "stim"
    # no data
    GET_PATCHES = "gpat"
    # no data
    DELETE_PKG_DIR = "dpkd"
    # no data
    GET_SOUP_INFO = "gsin"

    # Desktop -> Newton or Newton -> Desktop

    # data = entry being returned
    CHANGED_ENTRY = "cent"
    # variable length data
    TEST = "test"
    # no data
    HELLO = "helo"
    # data = soup info frame
    SOUP_INFO = "sinf"

    # ----------------------------------------------------------------------
    # Unknown commands.
    # Desktop -> Newton
    # Ouvre la fenêtre de progression.
    # Pas de données.
    UNKNOWN_DSNC = "dsnc"
    
    attr_accessor :length
    
    def to_binary
      b = "newtdock" + @command
      if @data
        b += [@data.length].pack("N") + @data + NSOF.padding(@data)
      else
        b += 0.chr + 0.chr + 0.chr + 0.chr
      end
      return b
    end
    
    def from_binary(b)
      c = b.unpack("A4A4A4N")
      @command = c[2]
      @length = c[3]
      @data = b.slice(16..-1)
    end
    
    def to_s
      return "DockCmd: #{@command}"
    end

  end

end