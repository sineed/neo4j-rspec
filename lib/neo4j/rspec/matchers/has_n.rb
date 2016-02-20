module Neo4j
  module RSpec
    module Matchers
      module HasN
        class AssociationMatcher
          def initialize(name, macro)
            @association = {}
            @association[:name] = name.to_sym
            @association[:macro] = macro
            @expectation_message = "#{macro_description} #{@association[:name]}"
          end

          def macro_description
            case @association[:macro]
            when :has_many then "have many"
            when :has_one then "have one"
            end
          end

          def with_direction(direction)
            @association[:direction] = direction
            @expectation_message << " with #{@association[:direction]} direction"
            self
          end

          def with_type(type)
            @association[:type] = type
            @expectation_message << " with #{@association[:type]} relationship type"
            self
          end

          def with_origin(origin)
            @association[:origin] = origin
            @expectation_message << " with #{@association[:origin]} origin"
            self
          end

          def with_model_class(model_class)
            @association[:model_classes] = Array(model_class)
            @expectation_message << " with #{@association[:model_classes].join(", ")} model classes"
            self
          end

          def matches?(actual)
            @actual = actual.class.associations[@association[:name]]

            unless @actual
              @negative_result_message = "no association named #{@association[:name]}"
              return false
            else
              @positive_result_message = "association named #{@association[:name]}"
            end

            if @association[:direction]
              if @association[:direction] != @actual.direction
                @negative_result_message = "#{@actual.inspect} wrong direction"
                return false
              else
                @positive_result_message = "#{@actual.inspect} wrong direction"
              end
            end

            if @association[:type]
              if @association[:type] != @actual.relationship_type
                @negative_result_message = "#{@actual.inspect} wrong relationship type"
                return false
              else
                @positive_result_message = "#{@actual.inspect} wrong relationship type"
              end
            end

            if @association[:origin]
              if @association[:origin] != @actual.relationship_type
                @negative_result_message = "#{@actual.inspect} wrong origin"
                return false
              else
                @positive_result_message = "#{@actual.inspect} wrong origin"
              end
            end

            if @association[:model_classes]
              if (@association[:model_classes] & Array(@actual.model_class)) != @association[:model_classes]
                @negative_result_message = "#{@actual.inspect} wrong model class"
                return false
              else
                @positive_result_message = "#{@actual.inspect} wrong model class"
              end
            end

            true
          end

          def failure_message
            "Expected #{@actual.inspect} to #{@expectation_message}, got #{@negative_result_message}"
          end

          def failure_message_when_negated
            "Expected #{@actual.inspect} to not #{@expectation_message}, got #{@positive_result_message}"
          end

          def description
            @expectation_message
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
