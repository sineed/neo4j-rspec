require 'rspec/expectations'

module Neo4j
  module RSpec
    module Matchers
      module Properties
        extend ::RSpec::Matchers::DSL

        matcher :track_creations do
          match do |model|
            model.attributes[:created_at] && model.attributes[:created_at][:type] == DateTime
          end

          failure_message do |model|
            "expected the #{model.name} model to track creations (`created_at`)"
          end
        end

        matcher :track_modifications do
          match do |model|
            model.attributes[:updated_at] && model.attributes[:updated_at][:type] == DateTime
          end

          failure_message do |model|
            "expected the #{model.name} model to track modifications (`updated_at`)"
          end
        end

        matcher :define_property do |name, type = nil|
          match do |model|
            model.attributes.key?(name.to_s) &&
              (type ? model.attributes[name.to_s][:type] == type : true)
          end

          failure_message do |model|
            "expected the #{model.name} model to have a `#{type}` property #{name}"
          end

          failure_message_when_negated do |model|
            "expected the #{model.name} model not to have a `#{type}` property #{name}"
          end
        end

        matcher :define_constraint do |name, type|
          fail ArgumentError, 'constraint name should be given' if name.blank?
          fail ArgumentError, 'constraint type should be given' if type.blank?

          match do |model|
            model.attributes.key?(name.to_s) &&
              model.attributes[name.to_s][:constraint] == type
          end

          failure_message do |model|
            "expected the #{model.name} model to have a #{type} constraint on #{name}"
          end

          failure_message_when_negated do |model|
            "expected the #{model.name} model not to have a #{type} constraint on #{name}"
          end
        end
      end
    end
  end
end

