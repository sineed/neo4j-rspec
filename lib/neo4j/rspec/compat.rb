module Neo4j
  module RSpec
    module Compat
      class << self
        def current
          current_class.new
        end

        private

        def current_class
          gem_version = Gem::Version.new(Neo4j::VERSION)
          gem_version >= Gem::Version.new('7.0.0') ? Neo4jrb7 : Neo4jrb6
        end
      end

      class Neo4jrb6
        def property_nesting
          ActiveAttr::Typecasting
        end

        def property_constraint?(attr, type)
          attr[:constraint] == type
        end
      end

      class Neo4jrb7
        def property_nesting
          Neo4j::Shared
        end

        def property_constraint?(attr, type)
          attr.constraint? type
        end
      end
    end
  end
end
