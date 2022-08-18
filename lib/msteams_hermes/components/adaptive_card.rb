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
      def initialize(args)
        super

        @body = args[:body]
        raise "AdaptiveCard `body` cannot be empty" if @body.nil?
        raise "AdaptiveCard `body` must be an Array" unless @body.is_a? Array

        @actions = args[:actions]
        raise "AdaptiveCard `actions` must be an Array" unless @actions.nil? || @actions.is_a?(Array)
      end

      def to_hash
        {
          type: "AdaptiveCard",
          version: "1.5",
          body: @body.map(&:to_hash),
          actions: @actions&.map(&:to_hash)
        }
      end
    end
  end
end
