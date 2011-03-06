#!/usr/bin/env ruby

$LOAD_PATH << File.join(File.dirname(__FILE__), '../../')

require "rdcl/communication/serial_layer_factory.rb"
require "rdcl/platform/platform.rb"
require "yaml"

include RDCL

settings = YAML::load(Platform.settings_file)

p = SerialLayerFactory.create
#p.connect(settings["serial_port"], settings["serial_speed"])
p.connect("COM4", 38400)
puts p.read(1)
p.disconnect