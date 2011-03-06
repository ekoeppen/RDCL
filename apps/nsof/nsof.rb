#!/usr/bin/env ruby

$LOAD_PATH.insert(0, "../../../")

require "rdcl/VERSION.rb"
require "rdcl/nsof/ns_object_factory.rb"
require "yaml"
require "getoptlong"

class NSOFCodec

  attr_accessor :args
  attr_accessor :data
  attr_accessor :cmd
  attr_accessor :output_filename
  attr_accessor :output_extension
  attr_accessor :opts
  attr_accessor :result
  
  def show_version
    puts "nsof/RDCL version #{RDCL_VERSION}"
  end
  
  def show_help
    h = <<EOT
  
  nsof: Newton Streamed Object Format encoder/decoder
  
  USAGE
  
    nsof <options> <file>
    
    Encodes or decodes the given file, if no file is given, reads the data from
    standard input.
    
  DECODING
  
    --decode, -d <format>
      Decodes the file or data using the specified format. Format can be one of:
      x: Decode to XML
      y: Decode to YAML
      t: Decode to text
      i: Decode I/O synced data
    
  ENCODING
  
    ...
  
EOT
    puts h
  end
  
  def decode_io_synced(data)
    objects = data.to_ruby
    suffix = "txt"
    if not @output_filename
      if objects[:"IC/VC:40hz"] and objects[:"IC/VC:40hz"][:suffix]
        suffix = objects[:"IC/VC:40hz"][:suffix]
      end
      @output_filename = objects[:title] + "." + suffix
    end
    @result = objects[:text]
  end
  
  def decode(args, data)
    r = ""
    data.slice!(0)
    decoder = RDCL::NSObjectFactory.new
    nsof = decoder.from_nsof_factory(data)
    case args
    when "x" then @result = nsof.to_xml
    when "y" then @result = nsof.to_yaml
    when "t" then @result = nsof.to_s
    when "i" then @result = decode_io_synced(nsof)
    end
  end
  
  def initialize
    @opts = GetoptLong.new(
      ["--help", "-h", GetoptLong::NO_ARGUMENT],
      ["--version", "-V", GetoptLong::NO_ARGUMENT],
      ["--decode", "-d", GetoptLong::REQUIRED_ARGUMENT],
      ["--encode", "-e", GetoptLong::NO_ARGUMENT]
    )
  end
  
  def run
    @opts.each do |opt, arg|
      case opt
      when "--help" then show_help; exit
      when "--version" then show_version; exit
      when "--decode" then @cmd = :decode; @args = String.new(arg)
      when "--encode" then @cmd = :encode
      end
    end
    
    if ARGV.length != 1
      @data = $stdin.read
    else
      @data = File.open(ARGV.shift, "rb") { |f| f.read }
    end
    
    if @cmd
      send(@cmd, @args, @data)
      print @result
    end
  end

end

NSOFCodec.new.run
