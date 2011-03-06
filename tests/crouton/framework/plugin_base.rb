require "rdcl/utils/actor.rb"

module RDCL

  class PluginBase < Actor
  
    attr_accessor :icon
    attr_accessor :container
    attr_accessor :active
    attr_accessor :workarea
    attr_accessor :app
    
    def initialize(parent, workarea, app)
      @active = false
      @workarea = workarea
      @app = app
    end

    def activate
      @container.activate(self)
      @active = true
      @icon.activate
    end
    
    def deactivate
      @active = false
      @icon.deactivate
    end
    
    def on_size(event)
    end
  
  end

end
