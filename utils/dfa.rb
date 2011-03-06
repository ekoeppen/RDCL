# State machines made simple. Here is an example. Read more in the DFA class
# documentation.
#       d = DFA.new('A', ['A','C'])
#       d.transition do |s,a|
#         ss = case [s, a]
#              when ['A', 0]: 'B'
#              when ['A', 1]: 'C'
#              when ['B', 0]: 'B'
#              when ['B', 1]: 'C'
#              when ['C', 0]: 'D'
#              when ['C', 1]: 'C'
#              when ['D', 0]: 'A'
#              when ['D', 1]: 'C'
#              else raise "Invalid transition (#{s}, #{a})"
#              end
#         print ss
#         ss
#       end
#       
#       ary = [0,0,0,1,1,1,0,1,1,1,0,0].map do |a|
#         d.eat a
#       end
#       puts
#       p ary

# A deterministic finite automata is defined as: (S,E,d,s0,F)
# where S is the set of states, E is the input alphabet, 
# d is the transition function (d: S x E -> S), s0 is the initial state, and F
# is the set of final states.
#
# In this implementation, we ignore S and E, and d may have side effects.  S
# and E are implicitly enforced by the transition function, which would
# probably raise an exception in the case of a bad (state, input) pair (but
# you can handle it however you like).
module DFA
  # transition_function responds to call(state,input), returning the successive state.
  # It may do anything else that you want it to do; this is how transitional
  # actions are implemented. 
  attr_accessor :transition_function
  # Final states. Responds to include?(state)
  attr_accessor :final_states
  # The current state.
  attr_accessor :state
  
  attr_accessor :log_transitions

  def init_automaton(s0, finals=[])
    @state = s0
    @final_states = finals
  end

  # Given an input symbol, transition the state machine according to the return
  # value of d, and return true if the now-current state is a final state, or
  # false otherwise.
  def automaton_input(a)
    new_state = @transition_function.call(@state,a)
    if @log_transitions
      puts("#{self.class}: #{state}(#{a}) -> #{new_state}\n")
    end
    @state = new_state
    return @final_states.include?(@state)
  end

  # Syntactic sugar for defining d. The block will be called with the current
  # state and input when automaton_input(a) is called.
  def transition(&block)
    @transition_function = block
  end
end
