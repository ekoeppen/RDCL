module RDCL
  
  class Model

    attr_accessor :newton_info
    attr_accessor :app
    
    def initialize(app)
      @app = app
    end

  end
  
end
