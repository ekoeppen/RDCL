require "rbconfig"
load "platform/platform.rb"
load "rake/packagetask.rb"
load "VERSION.rb"

BIN_DIR = "/usr/local/bin/"

if Platform::isWindows?
  BIN_DIR_WIN = ENV[:SystemRoot] + "\\system32\\"
end

INST_DIRS = [
  "apps",
  "communication",
  "link",
  "nsof",
  "package",
  "platform",
  "utils"
]

INST_BINFILES = [
  "apps/nwt/nwt",
  "apps/nsof/nsof"
]

INST_BINFILES_WIN = [
  "apps/nwt/nwt.bat",
  "apps/nsof/nsof.bat"
]

PCKG_DIRS = [
  "apps",
  "communication",
  "link",
  "nsof",
  "package",
  "platform",
  "utils",
  "test"
]

PCKG_FILES = [
  "COPYRIGHT",
  "README",
  "VERSION.rb",
  "Rakefile"
]

DOC_FILES = [
  "apps",
  "communication",
  "link",
  "nsof",
  "platform",
  "package",
  "utils",
  "README"
]

Rake::PackageTask.new("rdcl", RDCL_VERSION) do |p|
  p.need_zip = true
  PCKG_DIRS.each {|d| p.package_files.include(d + "/**/*")}
  PCKG_FILES.each {|f| p.package_files.include(f)}
end

task :compile_serial_support => ["utils/posix_serial_support/extconf.rb", "utils/posix_serial_support/posix_serial_support.c"] do
  p = Dir.pwd
  Dir.chdir("utils/posix_serial_support/")
  ruby "extconf.rb"
  sh "make"
  Dir.chdir(p)
end

task :clean_serial_support => ["utils/posix_serial_support/extconf.rb", "utils/posix_serial_support/posix_serial_support.c"] do
  p = Dir.pwd
  Dir.chdir("utils/posix_serial_support/")
  ruby "extconf.rb"
  sh "make clean"
  FileUtils.rm("Makefile")
  Dir.chdir(p)
end

task :install_serial_support => ["utils/posix_serial_support/extconf.rb", "utils/posix_serial_support/posix_serial_support.c"] do
  p = Dir.pwd
  Dir.chdir("utils/posix_serial_support/")
  sh "make install"
  Dir.chdir(p)
end

task :compile do
  if Platform::isPosix?
    if RUBY_VERSION =~ /1.9/
      Rake::Task["compile_serial_support"].invoke 
    else
      puts "Ruby 1.9 required."
      exit 1
    end
  end
end

task :clean do
  if Platform::isPosix?
    Rake::Task["clean_serial_support"].invoke 
  end
end

task :install do
  if Platform::isPosix? and not RUBY_VERSION =~ /1.9/
    puts "Ruby 1.9 required."
    exit 1
  end

  dest = Config::CONFIG["rubylibdir"] + "/rdcl/"
  FileUtils.remove_dir(dest, :force => true)
  FileUtils.mkdir(dest, :mode => 0755 )
  dirs = Array(INST_DIRS)
  files = ["VERSION.rb"]
  INST_DIRS.each do |dir|
    Dir[dir + "/**/*"].each do |src|
      if File.directory?(src) then dirs << src else files << src end
    end
  end
  dirs.each { |dir| FileUtils.mkdir_p(dest + dir, :mode => 0755) if not File.exist?(dest + dir) }
  files.each { |file| FileUtils.install(file, File.dirname(dest + file), :mode => 0644) }

  if Platform::isPosix?
    Rake::Task["install_serial_support"].invoke
    INST_BINFILES.each { |file| FileUtils.install(file, BIN_DIR, :mode => 0755) }
  elsif Platform::isWindows?
    INST_BINFILES_WIN.each { |file| FileUtils.install(file, BIN_DIR_WIN) }
  end
end

task :doc do
  readme = File.open("README") { |f| f.read.gsub(/VERSION .*/, "VERSION " + RDCL_VERSION) }
  File.open("README", "w") { |f| f.write(readme) }
  RDoc::RDoc.new.document(DOC_FILES)
end

task :default => [:compile]
