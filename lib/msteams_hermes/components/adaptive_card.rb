# frozen_string_literal: true

require "msteams_hermes/components/base"

module MsTeamsHermes
  ##
  # Module containing Microsoft's components representations
  ##
  module Components
    ##
    # A class representing Microsoft's AdaptiveCard object
    # https://adaptivecards.io/explorer/AdaptiveCard.html
    ##
    class AdaptiveCard < Base
      attr_reader :body, :actions, :entities

      def initialize(body:, actions: nil, entities: nil)
        @body = body
        raise "AdaptiveCard `body` must be an Array" unless @body.is_a? Array

        @actions = actions
        raise "AdaptiveCard `actions` must be an Array" unless @actions.nil? || @actions.is_a?(Array)

        @entities = entities
        raise "AdaptiveCard `entities` must be an Array" unless @entities.nil? || @entities.is_a?(Array)
      end

      def to_hash
        {
          type: "AdaptiveCard",
          version: "1.5",
          body: body.map(&:to_hash),
          actions: actions&.map(&:to_hash),
          msteams: { entities: entities&.map(&:to_hash) }
        }
      end
    end
  end
end
