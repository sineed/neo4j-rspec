$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "neo4j/rspec"
require "neo4j"
require "pry"

Dir[File.join(File.dirname(__FILE__), "nodes", "*.rb")].each { |file| require file }

RSpec.configure do |config|
  config.include Neo4j::RSpec::Matchers
end
