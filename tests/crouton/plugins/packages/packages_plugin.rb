require "rdcl/apps/crouton/framework/plugin_base.rb"
require "rdcl/apps/crouton/framework/sidebar_icon.rb"

module RDCL

  class PackagesPlugin < PluginBase
    
    attr_accessor :icon
    attr_accessor :text
  
    def initialize(parent, workarea, id, app)
      super(parent, workarea, app)
      @icon = SidebarIcon.new(self, parent, id, File.join(File.dirname(__FILE__), "packages.png"), "Packages")
      @text = Wx::TextCtrl.new(workarea, -1, 'Package List', Wx::DEFAULT_POSITION, Wx::DEFAULT_SIZE, Wx::TE_MULTILINE)
      @text.show(false)
    end
    
    def activate
      super()
      @text.show
    end
  
    def deactivate
      super()
      @text.show(false)
    end
  end
  
  def on_size(event)
    @text.set_client_size(event.get_size.get_width, event.get_size.get_height)
  end
end