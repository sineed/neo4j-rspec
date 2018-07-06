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
            "#{failure_start(rel)} to come from #{model_sym}"
          end

          failure_message_when_negated do |rel|
            "#{failure_start(rel)} not to come from #{model_sym}"
          end
        end

        matcher :lead_to do |model_sym|
          match do |rel|
            rel.class.to_class == model_sym
          end

          failure_message do |rel|
            "#{failure_start(rel)} to lead to #{model_sym}"
          end

          failure_message_when_negated do |rel|
            "#{failure_start(rel)} not to lead to #{model_sym}"
          end
        end

        matcher :have_relationship_type do |type|
          match do |rel|
            rel.type == type
          end

          failure_message do |rel|
            "#{failure_start(rel)} to have a relationship type #{type}"
          end

          failure_message_when_negated do |rel|
            "#{failure_start(rel)} not to have a relationship type #{type}"
          end
        end

        matcher :use_create_unique do |arg|
          match do |rel|
            rel.class.unique? && (arg.nil? || arg == rel.class.creates_unique_option)
          end

          description do
            msg = "use CREATE UNIQUE"
            msg += " with option #{arg}" if arg
            msg
          end

          failure_message do |rel|
            msg = "#{failure_start(rel)} to use CREATE UNIQUE clause"
            if arg
              actual = rel.class.creates_unique_option
              msg += "\n  expected option: #{arg}\n    actual option: #{actual}"
            end
            msg
          end

          failure_message_when_negated do |rel|
            msg = "#{failure_start(rel)} not to use CREATE UNIQUE clause"
            if arg
              actual = rel.class.creates_unique_option
              msg += "\n  expected option: #{arg}\n    actual option: #{actual}"
            end
            msg
          end
        end

        def failure_start(rel)
          "expected the #{rel.class.name} relation"
        end
      end
    end
  end
end

