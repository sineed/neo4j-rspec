module Neo4j
  module RSpec
    module Matchers
      module Relations
        extend ::RSpec::Matchers::DSL

        matcher :come_from do |model_sym|
          match do |rel|
            rel.class.from_class == model_sym
          end

          failure_message do |rel|
            "expected the #{rel.class.name} relation to come from #{model_sym}"
          end

          failure_message_when_negated do |rel|
            "expected the #{rel.class.name} relation not to come from #{model_sym}"
          end
        end

        matcher :lead_to do |model_sym|
          match do |rel|
            rel.class.to_class == model_sym
          end

          failure_message do |rel|
            "expected the #{rel.class.name} relation to lead to #{model_sym}"
          end

          failure_message_when_negated do |rel|
            "expected the #{rel.class.name} relation not to lead to #{model_sym}"
          end
        end

        matcher :have_relationship_type do |type|
          match do |rel|
            rel.type == type
          end

          failure_message do |rel|
            "expected the #{rel.class.name} relation to have a relationship type #{type}"
          end

          failure_message_when_negated do |rel|
            "expected the #{rel.class.name} relation not to have a relationship type #{type}"
          end
        end
      end
    end
  end
end

