module Neo4j
  module RSpec
    module Compat
      class << self
        def current
          case Neo4j::VERSION
          when /^6/ then Neo4jrb6.new
          when /^7/ then Neo4jrb7.new
          end
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
