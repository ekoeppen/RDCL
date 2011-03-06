#!/usr/bin/env ruby

$LOAD_PATH << File.join(File.dirname(__FILE__), '../../')

require 'rdcl/nsof/ns_object.rb'
require 'rdcl/nsof/ns_symbol.rb'
require 'rdcl/nsof/ns_string.rb'
require 'rdcl/nsof/ns_array.rb'
require 'rdcl/nsof/ns_integer.rb'
require 'rdcl/nsof/ns_plainarray.rb'
require 'rdcl/nsof/ns_frame.rb'
require 'rdcl/nsof/ns_object_factory.rb'
require 'rdcl/utils/hexdump.rb'
require 'rdcl/utils/unicode.rb'

include RDCL

o = NSString.new("test")
puts o.to_xml
puts o.to_nsof.hexdump
puts o.to_s

o = NSArray.new([NSString.new("eins"), NSString.new("zwei")], NSSymbol.new("data"))
puts o.to_xml
puts o.to_nsof.hexdump
puts o.to_s

o = NSFrame.new([
  [NSSymbol.new("tag"), NSString.new("value1")],
  [NSSymbol.new("data"), NSString.new("value2")],
])
puts o.to_xml
puts o.to_nsof.hexdump
puts o.to_s

o = NSPlainArray.new([NSString.new("eins"), NSString.new("zwei")])
puts o.to_xml
puts o.to_nsof.hexdump
puts o.to_s

o = NSInteger.new(2)
puts o.to_xml
puts o.to_nsof.hexdump
puts o.to_s

o = NSPlainArray.new([
  NSFrame.new([
    [NSSymbol.new("id"), NSInteger.new(2)],
    [NSSymbol.new("name"), NSString.new("Newton Connection Utilities")],
    [NSSymbol.new("version"), NSInteger.new(1)]
  ])
])
puts o.to_xml
puts o.to_nsof.hexdump
puts o.to_s

puts NSOF::decode_xlong("\x12")
puts NSOF::decode_xlong("\xff\x12\x34\x56\x78")

b = NSInteger.new(2).to_nsof +
  NSString.new("Test").to_nsof +
  NSPlainArray.new([NSString.new("Test"), NSInteger.new(2)]).to_nsof

f = NSObjectFactory.new
while b.length > 0
  n = f.from_nsof_factory(b)
  puts n.to_xml
end

f = File.new("log.txt")
b = f.read
f.close

f = NSObjectFactory.new
b.slice!(0)
obj = f.from_nsof_factory(b)
puts obj.to_s
puts obj.to_ruby

b = obj.to_ruby.to_nsof
f = NSObjectFactory.new
obj = f.from_nsof_factory(b)
puts obj.to_ruby

obj = {:queryspec => {:indexpath => :timestamp}, :soupname => "OutBox"}
puts obj.to_nsobject.to_xml

f = File.new("/tmp/test.nsof", "w+", File::CREAT | File::TRUNC)
f.write(2.chr)
f.write(obj.to_nsof)
f.close
