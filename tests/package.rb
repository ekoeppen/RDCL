#!/usr/bin/env ruby

$LOAD_PATH << File.join(File.dirname(__FILE__), '../../')

require 'rdcl/package/package_directory.rb'
require 'yaml'

include RDCL

p = File.open(ARGV[0]) { |f| f.read }
d = PackageDirectory.new
d.parse(p)
puts d.to_yaml