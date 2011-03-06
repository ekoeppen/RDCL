#!/usr/bin/env ruby

$LOAD_PATH << File.join(File.dirname(__FILE__), '../../')

require 'rdcl/nsof/ns_object.rb'
require 'rdcl/nsof/ns_symbol.rb'
require 'rdcl/nsof/ns_string.rb'
require 'rdcl/nsof/ns_array.rb'
require 'rdcl/nsof/ns_plainarray.rb'
require 'rdcl/nsof/ns_frame.rb'
require 'rdcl/utils/hexdump.rb'
require 'rdcl/utils/unicode.rb'
require 'rdcl/link/dock_cmds/dock_cmd_desktop_info.rb'
require 'rdcl/link/dock_cmds/dock_cmd_devices.rb'
require 'rdcl/link/dock_cmds/dock_cmd_path.rb'
require 'rdcl/link/dock_cmds/dock_cmd_initiate_docking.rb'
require 'rdcl/link/dock_cmds/dock_cmd_filters.rb'
require 'rdcl/link/dock_cmds/dock_cmd_files_and_folders.rb'

include RDCL

#d = DockCmdPath.new(Dir.getwd)
#d = DockCmdDesktopInfo.new
#d = DockCmdDevices.new
#d = DockCmdFilters.new
d = DockCmdFilesAndFolders.new(Dir.getwd)
puts d.to_binary.hexdump
