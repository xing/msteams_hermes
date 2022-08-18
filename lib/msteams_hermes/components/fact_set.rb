# frozen_string_literal: true

require "msteams_hermes/style"

module MsTeamsHermes
  ##
  # Module containing Microsoft's components representations
  ##
  module Components
    ##
    # A class representing Microsoft's FactSet object
    # https://adaptivecards.io/explorer/FactSet.html
    ##
    class FactSet < Base
      def initialize(args)
        super

        @facts = args[:facts]
        raise "FactSet `facts` cannot be empty" if @facts.nil?
        raise "FactSet `facts` must be an Array of hashes containing only title and value keys" unless valid_facts?
      end

      def to_hash
        {
          type: "FactSet",
          facts: @facts
        }
      end

      private

      def valid_facts?
        @facts.is_a?(Array) && @facts.all? do |fact|
          extra_keys = fact.keys - %i[title value]
          fact.is_a?(Hash) && extra_keys.empty?
        end
      end
    end
  end
end
