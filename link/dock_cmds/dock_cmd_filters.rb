require "rdcl/link/dock_cmds/dock_cmd.rb"
require "rdcl/nsof/ns_nil.rb"

module RDCL

  class DockCmdFilters < DockCmd

    def initialize
      @command = DockCmd::FILTERS
      @data = 2.chr + NSNil.new.to_nsof
    end

  end

end
