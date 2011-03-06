require "rdcl/link/dock_link.rb"
require "rdcl/utils/dfa.rb"

module RDCL

  class DockModule
    
    include DFA
    
    attr_accessor :link
    attr_accessor :command
    attr_accessor :id
    
    def initialize(link, id)
      @link = link
      @command = nil
      @log_transitions = nil
      @id = id
      @link.dock_modules << self

      init_automaton :idle, [:idle]
      transition do |s, a|
        nil
      end
    end

    def process_message(b)
      @command = b
      automaton_input(@command.command)
    end
    
    def dock_write(data)
#      puts ">>>\n" + data.to_yaml
      @link.dock_layer.write(data)
    end
    
    def app_receive(data)
      @link.application.receive(data)
    end

  end
  
end