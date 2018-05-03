lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'neo4j/rspec/version'

Gem::Specification.new do |spec|
  spec.name          = 'neo4j-rspec'
  spec.version       = Neo4j::RSpec::VERSION
  spec.authors       = ['Denis Tataurov']
  spec.email         = ['sineedus@mail.ru']

  spec.summary       = 'RSpec matchers for Neo4j.rb'
  spec.description   = 'RSpec matchers for Neo4j.rb'
  spec.homepage      = 'https://github.com/sineed/neo4j-rspec'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.add_dependency 'neo4j', '>= 6.0.0'
  spec.add_dependency 'rspec', '>= 3.0'
end
