# frozen_string_literal: true

require "msteams_hermes/components/base"
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
      attr_reader :facts

      def initialize(facts:)
        @facts = facts
        raise "FactSet `facts` must be an Array of hashes containing title and value keys" unless valid_facts?
      end

      def to_hash
        {
          type: "FactSet",
          facts:
        }
      end

      private

      def valid_facts?
        facts.is_a?(Array) && facts.all? do |fact|
          extra_keys = %i[title value] - fact.keys
          fact.is_a?(Hash) && extra_keys.empty?
        end
      end
    end
  end
end
