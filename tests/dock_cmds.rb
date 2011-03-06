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
require 'rdcl/link/commands/dock_cmd_factory.rb'

include RDCL

#o = DockCmd.new("dock", nil)
#o.to_binary.hexdump
o = DockCmdFactory.from_binary_factory("newtdockgpin\0\0\0\4abcd")
o.to_binary.hexdump
puts o.class