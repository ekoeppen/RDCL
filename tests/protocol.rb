#!/usr/bin/env ruby

$LOAD_PATH << File.join(File.dirname(__FILE__), "../../")

require "rdcl/link/serial_dock_link.rb"
require "rdcl/link/app_cmds/app_cmd_disconnected.rb"
require "rdcl/utils/des.rb"
require "yaml"

include RDCL

Thread.abort_on_exception = true

settings = YAML::load(File.new(Platform.settings_file))

dock = SerialDockLink.new(settings)

app = Actor.new
app.transition do |state, action|
  puts "<<<\n" + action.to_yaml
  if action.command == AppCmd::DISCONNECTED
    exit
  end
  state
end
app.run

dock.application = app
dock.run

ui = Thread.new do
  gets
end
ui.run

ui.join