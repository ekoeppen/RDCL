require "rdcl/apps/crouton/framework/plugin_base.rb"
require "rdcl/apps/crouton/framework/sidebar_icon.rb"

module RDCL

  class InfoPlugin < PluginBase
    
    attr_accessor :icon
    attr_accessor :text
    attr_accessor :app
  
    def initialize(parent, workarea, id, app)
      super(parent, workarea, app)
      @icon = SidebarIcon.new(self, parent, id, File.join(File.dirname(__FILE__), "inspector.png"), "Info")
      @text = Wx::TextCtrl.new(workarea, -1, 'Device Information', Wx::DEFAULT_POSITION, Wx::DEFAULT_SIZE, Wx::TE_MULTILINE | Wx::TE_READONLY)
      @text.show(false)
    end
    
    def activate
      super()
      @text.change_value(@app.model.newton_info.to_s)
      @text.show
#      size = @workarea.get_size
#      @text.set_client_size(size.get_width, size.get_height)
    end
  
    def deactivate
      super()
      @text.show(false)
    end
    
    def on_size(event)
      @text.set_client_size(event.get_size.get_width, event.get_size.get_height)
    end
  
  end
  
end