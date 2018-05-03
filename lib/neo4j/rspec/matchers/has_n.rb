module Neo4j
  module RSpec
    module Matchers
      module HasN
        module With
          class Base
            attr_reader :expected

            def initialize(expected)
              @expected = expected
            end
          end

          class DirectionMatcher < Base
            def match(association)
              expected == association.direction
            end

            def description
              "with #{expected} direction"
            end
          end

          class OriginMatcher < Base
            def match(association)
              expected == association.relationship_type
            end

            def description
              "with #{expected} origin"
            end
          end

          class TypeMatcher < Base
            def match(association)
              expected == association.relationship_type
            end

            def description
              "with #{expected} type"
            end
          end

          class ModelClassMatcher < Base
            def match(association)
              actual = association.target_classes.map { |m| m.to_s.to_sym }
              actual & expected == actual
            end

            def description
              "with #{expected.join(', ')} model class"
            end
          end

          class RelationshipClassMatcher < Base
            def match(association)
              association.relationship_class_name.to_sym == expected.to_sym
            end

            def description
              "with #{expected} relationship class"
            end
          end
        end

        module Without
          class TypeMatcher
            def match(association)
              !association.relationship_type
            end

            def description
              'without type'
            end
          end
        end

        class HaveMany
          def name
            :have_many
          end

          def description(model_name)
            "have many #{model_name}"
          end

          def failure_message(model_name)
            "expected the #{model_name} model to have many #{name}"
          end
        end

        class HaveOne
          def name
            :have_one
          end

          def description(model_name)
            "have one #{model_name}"
          end

          def failure_message(model_name)
            "expected the #{model_name} model to have one #{name}"
          end
        end

        extend ::RSpec::Matchers::DSL

        [HaveMany.new, HaveOne.new].each do |macro|
          matcher macro.name do |association_name|
            def matchers
              @matchers ||= []
            end

            match do |model|
              association = model.class.associations[association_name]
              association && matchers.all? { |m| m.match(association) }
            end

            chain :with_direction do |direction|
              matchers.push With::DirectionMatcher.new(direction)
            end

            chain :with_origin do |origin|
              matchers.push With::OriginMatcher.new(origin)
            end

            chain :with_type do |type|
              matchers.push With::TypeMatcher.new(type)
            end

            chain :with_model_class do |*model_classes|
              matchers.push With::ModelClassMatcher.new(model_classes)
            end

            chain :with_rel_class do |rel_class|
              matchers.push With::RelationshipClassMatcher.new(rel_class)
            end

            chain :without_type do
              matchers.push Without::TypeMatcher.new
            end

            description do |_model|
              with_messages = matchers.map(&:description).join(' ')
              macro.description(association_name) + ' ' + with_messages
            end

            failure_message do |model|
              with_messages = matchers.map(&:description).join(' ')
              macro.failure_message(model.class.name) + ' ' + with_messages
            end
          end
        end
      end
    end
  end
end
