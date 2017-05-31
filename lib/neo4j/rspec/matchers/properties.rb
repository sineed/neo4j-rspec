require 'rspec/expectations'

module Neo4j
  module RSpec
    module Matchers
      module Properties
        extend ::RSpec::Matchers::DSL

        matcher :track_creations do
          match do |model|
            klass = model.class
            klass.attributes[:created_at] && klass.attributes[:created_at][:type] == DateTime
          end

          failure_message do |model|
            "expected the #{model.class.name} model to track creations (`created_at`)"
          end
        end

        matcher :track_modifications do
          match do |model|
            klass = model.class
            klass.attributes[:updated_at] && klass.attributes[:updated_at][:type] == DateTime
          end

          failure_message do |model|
            "expected the #{model.class.name} model to track modifications (`updated_at`)"
          end
        end

        matcher :define_property do |name, type = nil|
          match do |model|
            name = name.to_s

            expected_type = Neo4j::Shared.const_get(type.to_s) if type
            model.class.attributes.key?(name) && model.class.attributes[name].type == expected_type
          end

          failure_message do |model|
            "expected the #{model.class.name} model to have a `#{type}` property #{name}"
          end

          failure_message_when_negated do |model|
            "expected the #{model.class.name} model not to have a `#{type}` property #{name}"
          end
        end

        matcher :define_constraint do |name, type|
          fail ArgumentError, 'constraint name should be given' if name.blank?
          fail ArgumentError, 'constraint type should be given' if type.blank?

          match do |model|
            klass = model.class
            klass.attributes.key?(name.to_s) &&
              Neo4j::RSpec::Compat.current.property_constraint?(klass.attributes[name.to_s], type)
          end

          failure_message do |model|
            "expected the #{model.class.name} model to have a #{type} constraint on #{name}"
          end

          failure_message_when_negated do |model|
            "expected the #{model.class.name} model not to have a #{type} constraint on #{name}"
          end
        end

        matcher :define_index do |name|
          fail ArgumentError, 'index name should be given' if name.blank?

          match do |model|
            model.class.attributes.key?(name.to_s) &&
              model.declared_properties[name.to_s].index?
          end

          failure_message do |model|
            "expected the #{model.class.name} model to have an exact index on #{name} property"
          end

          failure_message_when_negated do |model|
            "expected the #{model.class.name} model not to have an exact index on #{name} property"
          end
        end
      end
    end
  end
end

