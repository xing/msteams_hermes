# frozen_string_literal: true

require "msteams_hermes/style"

module MsTeamsHermes
  module Components
    class FactSet < Base
      def initialize(args)
        super

        @facts = args[:facts]
        raise "FactSet `facts` cannot be empty" if @facts.nil?
        raise "FactSet `facts` must be an Array" unless @facts.is_a? Array
      end

      def to_hash
        {
          type: "FactSet",
          facts: @facts
        }
      end
    end
  end
end
