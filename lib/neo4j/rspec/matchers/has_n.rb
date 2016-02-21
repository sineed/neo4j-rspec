module Neo4j
  module RSpec
    module Matchers
      module HasN
        class BaseMatcher
          attr_reader :matcher, :value, :key, :actual

          def initialize(matcher, value)
            @matcher = matcher
            @value = convert_value(value)
          end

          def add
            matcher.expectation_message << expectation_message
            matcher.association[key] = self
            matcher
          end

          def add_negative
            matcher.expectation_message << negative_expectation_message
            matcher.association[key] = self
            matcher
          end

          def matches?(actual)
            @actual = extact_actual(actual)
            if matches
              matcher.negative_result_message = result_message
              false
            else
              matcher.positive_result_message = result_message
              true
            end
          end

          private

          def matches
            value != actual
          end

          def convert_value(val)
            val
          end
        end

        class DirectionMatcher < BaseMatcher
          private

          def key
            :direction
          end

          def extact_actual(actual)
            actual.direction
          end

          def expectation_message
            " with #{value} direction"
          end

          def result_message
            "#{actual} direction"
          end
        end

        class TypeMatcher < BaseMatcher
          private

          def key
            :type
          end

          def extact_actual(actual)
            actual.relationship_type
          end

          def expectation_message
            " with #{value} relationship type"
          end

          def negative_expectation_message
            " without relationship type"
          end

          def result_message
            "#{actual} relationship type"
          end
        end

        class OriginMatcher < BaseMatcher
          private

          def key
            :origin
          end

          def extact_actual(actual)
            actual.relationship_type
          end

          def expectation_message
            " with #{value} origin"
          end

          def result_message
            "#{actual} origin"
          end
        end

        class ModelClassesMatcher < BaseMatcher
          private

          def key
            :model_classes
          end

          def convert_value(val)
            Array(val)
          end

          def extact_actual(actual)
            Array(actual.model_class)
          end

          def matches
            (value & actual) != value
          end

          def expectation_message
            " with #{value.join(", ")} model classes"
          end

          def result_message
            "#{actual.join(", ")} model classes"
          end
        end


        class AssociationMatcher
          attr_accessor :association, :expectation_message, :negative_result_message,
            :positive_result_message

          def initialize(name, macro)
            @association = {}
            @association[:name] = name.to_sym
            @association[:macro] = macro
            @expectation_message = "#{macro_description} #{@association[:name]}"
          end

          def macro_description
            case association[:macro]
            when :has_many then "have many"
            when :has_one then "have one"
            end
          end

          def matchers
            association.select { |_, v| v.is_a? BaseMatcher }
          end

          def with_direction(direction)
            DirectionMatcher.new(self, direction).add
          end

          def with_type(type)
            TypeMatcher.new(self, type).add
          end

          def without_type
            TypeMatcher.new(self, false).add_negative
          end

          def with_origin(origin)
            OriginMatcher.new(self, origin).add
          end

          def with_model_class(model_class)
            ModelClassesMatcher.new(self, model_class).add
          end

          def matches?(actual)
            @actual = actual
            actual_association = actual.class.associations[association[:name]]

            unless actual_association
              self.negative_result_message = "no association named #{association[:name]}"
              return false
            else
              self.positive_result_message = "association named #{association[:name]}"
            end

            matchers.each do |_, matcher|
              return false unless matcher.matches?(actual_association)
            end

            true
          end

          def failure_message
            "Expected #{@actual.class} to #{expectation_message}, got #{negative_result_message}"
          end

          def failure_message_when_negated
            "Expected #{@actual.class} to not #{expectation_message}, got #{positive_result_message}"
          end

          def description
            expectation_message
          end
        end

        def have_many(association_name)
          AssociationMatcher.new(association_name, :has_many)
        end

        def have_one(association_name)
          AssociationMatcher.new(association_name, :has_one)
        end
      end
    end
  end
end
