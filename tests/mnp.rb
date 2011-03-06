#!/usr/bin/env ruby

$LOAD_PATH << File.join(File.dirname(__FILE__), "../../")

require "rdcl/communication/protocol_layer.rb"
require "rdcl/communication/serial_layer.rb"
require "rdcl/communication/replay_layer.rb"
require "rdcl/communication/loopback_layer.rb"
require "rdcl/communication/log_layer.rb"
require "rdcl/communication/mnp_packet_layer.rb"
require "rdcl/communication/mnp_logical_layer.rb"
require "rdcl/communication/async_bridge_layer.rb"

include RDCL

replay = ReplayLayer.new
replay.replay_data = "\x16\x10\x02\x03\x05\x01\x08\x10\x03\xba\xbe\xff"

mnp = MNPPacketLayer.new
mnp.insert_above(replay)

log2 = LogLayer.new "MNP decoded"
log2.insert_above(mnp)

puts tlog2.read
log2.read
