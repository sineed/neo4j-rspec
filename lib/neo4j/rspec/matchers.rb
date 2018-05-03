require 'neo4j/rspec/matchers/has_n'
require 'neo4j/rspec/matchers/properties'
require 'neo4j/rspec/matchers/relations'
require 'neo4j/rspec/compat'

module Neo4j
  module RSpec
    module Matchers
      include HasN
      include Properties
      include Relations
    end
  end
end
