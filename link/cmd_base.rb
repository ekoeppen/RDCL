module RDCL
  
  class CmdBase
    
    attr_accessor :command
    attr_accessor :data
    
    def initialize(cmd = nil, data = nil)
      @command = cmd
      @data = data
    end
    
    def to_s
      return "Cmd: #{@command}"
    end

  end

end
