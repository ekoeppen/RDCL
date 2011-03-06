#!/usr/bin/env ruby

$LOAD_PATH << File.join(File.dirname(__FILE__), "../../")

require "rdcl/link/serial_dock_link.rb"
require "rdcl/link/app_cmds/app_cmd_disconnect.rb"
require "rdcl/link/app_cmds/app_cmd_get_app_list.rb"
require "yaml"
require "wx"

include RDCL

Thread.abort_on_exception = true

class SidebarIcon < Wx::Window
  attr :bitmap
  attr :text
  attr :active
  
  def initialize(parent, id, file_name, text)
    super(parent, id, Wx::Point.new(0, 0), Wx::Size.new(128, 48), Wx::NO_BORDER)

    @bitmap = Wx::Bitmap.new(File.join( File.dirname(__FILE__), file_name), Wx::BITMAP_TYPE_PNG)
    @text = text
    @active = false

    evt_paint do
      on_paint
    end
    
    evt_left_up do
      on_click
    end
    
  end

  def on_paint
    paint do | dc |
      dc.set_background(active ? Wx::LIGHT_GREY_BRUSH : Wx::WHITE_BRUSH)
      dc.clear
      dc.draw_bitmap(@bitmap, 4, 8, false)
      dc.draw_text(@text, 40, 16)
    end
  end
  
  def on_click
    event = Wx::CommandEvent.new(Wx::EVT_COMMAND_BUTTON_CLICKED, get_id)
    add_pending_event(event)
  end

end

class WxNewton < Wx::App  # a new class which derives from the Wx::App class

  attr_accessor :dock
  attr_accessor :app
  attr_accessor :settings

  def initialize 
    super

    @settings = YAML::load(File.new("settings.yaml"))
    @app = Actor.new
    @app.transition {|s, a| puts a}
    @app.run

#    @dock = SerialDockLink.new(settings)
#    @dock.application = @app
#    @dock.run
  end

  def on_init  # we're defining what the application is going to do when it starts
    t = Wx::Timer.new(self, 55)
    evt_timer(55) { Thread.pass }
    t.start(5)

    frame = Wx::Frame.new(nil, -1, 'WxNewton')
    frame.set_client_size(Wx::Size.new(400,200))
    frame.set_background_colour(Wx::WHITE)
    
    status = Wx::StatusBar.new(frame, 100)
    status.set_status_text("Disconnected")

    sizer = Wx::BoxSizer.new(Wx::HORIZONTAL)

    button_list = Wx::BoxSizer.new(Wx::VERTICAL)

    info_button = SidebarIcon.new(frame, 10, "inspector.png", "Info")
    button_list.add(info_button, 0, Wx::ALIGN_RIGHT, 2)

    app_button = SidebarIcon.new(frame, 40, "applications.png", "Info")
    button_list.add(app_button, 0, Wx::ALIGN_RIGHT, 2)

    soups_button = SidebarIcon.new(frame, 50, "documents.png", "Soups")
    button_list.add(soups_button, 0, Wx::ALIGN_RIGHT, 2)

    text = Wx::TextCtrl.new(frame, -1, 'Type in here',
                            Wx::DEFAULT_POSITION, Wx::DEFAULT_SIZE,
                            Wx::TE_MULTILINE)
    sizer.add(button_list, 0, Wx::ALIGN_RIGHT, 2)
    sizer.add(text, 1, Wx::GROW|Wx::ALL, 2)

    frame.set_sizer(sizer)
    frame.show()

    evt_button(app_button) {|event| get_app_list}
  end
  
  def get_app_list
    @dock.receive(AppCmdGetAppList.new)
  end

end

n = WxNewton.new
n.main_loop

