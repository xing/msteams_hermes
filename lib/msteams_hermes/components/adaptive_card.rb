# frozen_string_literal: true

require "msteams_hermes/components/base"
require "msteams_hermes/style"

module MsTeamsHermes
  ##
  # Module containing Microsoft's components representations
  ##
  module Components
    include MsTeamsHermes::Style
    ##
    # A class representing Microsoft's AdaptiveCard object
    # https://adaptivecards.io/explorer/AdaptiveCard.html
    ##
    class AdaptiveCard < Base
      attr_reader :body, :actions, :entities, :width

      def initialize(body:, actions: nil, entities: [], width: Style::Width::DEFAULT)
        @body = body
        raise "AdaptiveCard `body` must be an Array" unless @body.is_a? Array

        @actions = actions
        raise "AdaptiveCard `actions` must be an Array" unless @actions.nil? || @actions.is_a?(Array)

        @entities = entities
        raise "AdaptiveCard `entities` must be an Array" unless @entities.nil? || @entities.is_a?(Array)

        @width = width
        raise "AdaptiveCard `width` must be one of the available Width options" unless Style::Width.all.include?(width)
      end

      def to_hash
        {
          type: "AdaptiveCard",
          version: "1.5",
          body: body.map(&:to_hash),
          actions: actions&.map(&:to_hash),
          msteams: {
            entities: entities.map(&:to_hash),
            width:
          }
        }
      end
    end
  end
end
