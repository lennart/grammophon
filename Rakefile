require 'config/boot'
# Optionally load gems from a server other than rubyforge:
# set_sources 'http://gems.projectsprouts.org'
sprout 'flex4'

project_model :model do |m|
  m.project_name            = 'Grammophon'
  m.language                = 'mxml'
  m.background_color        = '#FFFFFF'
  m.width                   = 970
  m.height                  = 550
  m.compiler_gem_name     = 'sprout-flex4sdk-tool'
  m.compiler_gem_version  = '>= 4.0.0'
  m.source_path               << 'lib/as3playdar/src'
  m.source_path               << 'lib/yajl/as3/src'
  m.lib_dir               = 'lib'
  m.swc_dir               = 'lib'
  m.bin_dir               = 'public/jukebox'
unless ENV["NOFCSH"] 
  m.use_fcsh = true
end
  # m.test_dir              = 'test'
  # m.doc_dir               = 'doc'
  # m.asset_dir             = 'assets'
  
  m.library_path.concat         FileList["#{m.lib_dir.to_s}/*.swc"].to_a
  m.libraries.concat [:robotlegs, :swiftsuspenders, :corelib, :"jukeboxapi-src",:"as3httpclient-src"]
end


desc 'Compile and debug the application'
debug :debug => :model do |m|
  m.debug = true
end

desc 'Set lib folder to' 
task :lib do
  pp YAML.load_file("NATURE")
end


desc 'Compile run the test harness'
unit :test

desc 'Compile the optimized deployment'
deploy :deploy

desc "Debug the App"
fdb :app => :model do |t|
  t.file = "public/jukebox/Grammophon-debug.swf"
  t.run
  #t.break = 'SomeFile:23'
  #t.continue
end

namespace :ext do
  desc "Do something with extensions"
  task :compile do |t|
    Dir.chdir("lib/yajl") do
      puts `rake lib`
      ENV["TO"] = File.join(File.expand_path(File.dirname(__FILE__)),"lib")
      puts `rake install`
    end
  end

  desc "Do something with extensions"
  task :clean do |t|
    Dir.chdir("lib/yajl") do
      `rake clean`
    end
  end
end

desc 'Create documentation'
document :doc

desc 'Compile a SWC file'
swc :swc

desc "to Shell"
task :shell do
  tasks = Rake::Task.tasks.map do |t|
    begin
      t.to_shell
    rescue
    end
  end.compact

  pp tasks
end

# set up the default rake task
task :default => :debug
