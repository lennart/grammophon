require 'rubygems'
ENV["AIRAKE_ROOT"] = File.dirname(__FILE__)
ENV["AIRAKE_ENV"] = "development"
require File.join(ENV["AIRAKE_ROOT"],"config","boot")

require 'flexPartyPlayer/tasks'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "flexPartyPlayer"
    gemspec.summary = "A Flex Frontend to KitNo"
    gemspec.description = "A Flex Frontend to KitNo"
    gemspec.email = "github@varga-net"
    gemspec.homepage = "http://github.com/FrancisVarga/flexPartyPlayer/"
    gemspec.authors = ["Francis Varga"]
    gemspec.add_dependency('airake')
    gemspec.add_dependency('rake')

    files = FileList[%w{src/**/* test/* views/* lib/* script/* sample.json airake.yml Gemfile}]
    gemspec.files = files.to_a
  end
  Rake.application.jeweler.gemspec.executables = []
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end
