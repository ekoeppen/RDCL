require "rdcl/apps/crouton/framework/plugin_base.rb"

require "wx"

module RDCL

  class PluginContainer
    
    attr_accessor :sizer
    attr_accessor :plugins
    attr_accessor :active_plugin
    
    def initialize
      @sizer = Wx::BoxSizer.new(Wx::VERTICAL)
      @plugins = []
    end
    
    def add_plugin(plugin)
      @plugins << plugin
      @sizer.add(plugin.icon, 0, Wx::ALIGN_RIGHT, 2)
      plugin.container = self
    end
    
    def activate(plugin)
      @plugins.each do |p|
        if not plugin == p
          p.deactivate
        end
      end
      @active_plugin = plugin
    end
    
    def on_size(event)
      @active_plugin.on_size(event) if @active_plugin 
    end
    
  end
  
end
