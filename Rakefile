require 'config/boot'
# Optionally load gems from a server other than rubyforge:
# set_sources 'http://gems.projectsprouts.org'
sprout 'flex4'

def expand path
  File.expand_path(path)
end

project_model :model do |m|
  m.project_name            = 'Grammophon'
  m.language                = 'mxml'
  m.default_size          = "800 480"
  m.background_color        = '#FFFFFF'
  m.compiler_gem_name     = 'sprout-flex4sdk-tool'
  m.compiler_gem_version  = '>= 4.0.0'
  m.source_path               << 'lib/as3playdar/src'
  m.lib_dir               = expand('lib')
  m.swc_dir               = expand('lib')
  m.bin_dir               = expand('public/jukebox')
unless ENV["NOFCSH"] 
  m.use_fcsh = true
end
  # m.test_dir              = 'test'
  # m.doc_dir               = 'doc'
  m.src_dir = expand('src')
  
  m.library_path.concat         FileList["#{m.lib_dir.to_s}/**/*.swc"].to_a
  m.libraries.concat [:robotlegs, :swiftsuspenders, :corelib, :"jukeboxapi-src",:"as3httpclient-src", :yajl]
  m.source_path.map! {|p| expand p }
  m.library_path.map! {|p| expand p }
  m.asset_dir = expand m.asset_dir 
end


desc 'Compile and debug the application'
debug :debug => :model do |m|
  m.debug = true
end

task :compile => [:model, "public/jukebox/Grammophon-debug.swf"]


desc 'Set lib folder to' 
task :lib do
  pp YAML.load_file("NATURE")
end


desc 'Compile run the test harness'
unit :test

desc 'Compile the optimized deployment'
deploy :deploy => :model do |m|
  m.prepended_args = "-keep-as3-metadata+=Inject"
end

desc "Debug the App"
fdb :app => :model do |t|
  t.file = "public/jukebox/Grammophon-debug.swf"
  t.run
end

namespace :ext do
  desc "Do something with extensions"
  task :compile do |t|
    Dir.chdir("lib/yajl") do
      puts `rake lib`
      ENV["TO"] = File.join(File.expand_path(File.dirname(__FILE__)),"lib")
      ENV["QUIET"] = "yes"
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
