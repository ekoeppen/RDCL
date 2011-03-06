require "wx"

  module RDCL

  class SidebarIcon < Wx::Window
    attr_accessor :bitmap
    attr_accessor :text
    attr_accessor :active
    attr_accessor :plugin
    
    def initialize(plugin, parent, id, file_name, text)
      super(parent, id, Wx::Point.new(0, 0), Wx::Size.new(128, 48), Wx::NO_BORDER)

      @plugin = plugin
      @bitmap = Wx::Bitmap.new(file_name, Wx::BITMAP_TYPE_PNG)
      @text = text
      @active = false

      evt_paint do
        on_paint
      end
      
      evt_left_up do
        on_click
      end
      
      evt_button(self) do |event|
        @plugin.activate
      end
    end

    def on_paint
      paint do |dc|
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
    
    def activate
      @active = true
      refresh
      update
    end

    def deactivate
      @active = false
      refresh
      update
    end

  end

end