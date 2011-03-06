require "rdcl/link/serial_dock_link.rb"
require "rdcl/link/app_cmds/app_cmd_disconnect.rb"
require "rdcl/link/app_cmds/app_cmd_get_app_list.rb"
require "rdcl/apps/crouton/framework/sidebar_icon.rb"
require "rdcl/apps/crouton/framework/plugin_container.rb"
require "rdcl/apps/crouton/plugins/info/info_plugin.rb"
require "rdcl/apps/crouton/plugins/packages/packages_plugin.rb"
require "wx"

module RDCL
  
  class Controller < Actor

    attr_accessor :app

    def initialize(app)
      super()
      @app = app
      transition do |s, a|
        if a.command == AppCmd::PROGRESS
          @app.status_bar.set_status_text(a.to_s)
        elsif a.command == AppCmd::NEWTON_NAME
          @app.model.newton_info = a.to_s
          puts a.to_s
        end
      end
    end

    def get_app_list
      @app.dock.receive(AppCmdGetAppList.new)
    end

  end
  
end
