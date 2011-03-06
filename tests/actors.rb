#!/usr/bin/env ruby

$LOAD_PATH << File.join(File.dirname(__FILE__), "../../")

require "rdcl/utils/actor.rb"

include RDCL

a = Actor.new
b = Actor.new

a.transition do |state, action|
  puts action
  puts state
  state
end

b.transition do |state, action|
  puts action
  puts state
  state
end

c = Thread.new do
  while true do
    a.receive_message("Test A")
    b.receive_message("Test B")
    sleep(5)
  end
end

c.join