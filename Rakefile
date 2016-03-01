require 'rake'
require 'bundler/gem_tasks'
require 'neo4j-core'
require 'neo4j/rake_tasks'
require "rspec/core/rake_task"

task default: :spec

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = "./spec/**/*_spec.rb"
end
