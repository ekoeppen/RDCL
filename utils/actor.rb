require "async"
require "rdcl/utils/dfa.rb"

module RDCL

  class Actor
  
    include DFA
  
    attr_accessor :message_queue
  
    def initialize
      init_automaton(:idle)
      transition {|s, a| s}
      @message_queue = Queue.new
    end
    
    def run
      message_loop
    end
  
    def process_message(message)
      automaton_input(message)
    end
  
    def message_loop
      while true
        process_message(@message_queue.pop)
      end
    end
  
    def receive(message)
      @message_queue.push(message)
    end
  
  end

end
