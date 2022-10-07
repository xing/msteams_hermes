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
      attr_reader :body, :actions

      def initialize(body:, actions: nil)
        @body = body
        raise "AdaptiveCard `body` must be an Array" unless @body.is_a? Array

        @actions = actions
        raise "AdaptiveCard `actions` must be an Array" unless @actions.nil? || @actions.is_a?(Array)
      end

      def to_hash
        {
          type: "AdaptiveCard",
          version: "1.5",
          body: body.map(&:to_hash),
          actions: actions&.map(&:to_hash)
        }
      end
    end
  end
end
