require "neo4j/rspec/matchers/has_n"
require "neo4j/rspec/matchers/properties"

module Neo4j
  module RSpec
    module Matchers
      include HasN
      include Properties
    end
  end
end
