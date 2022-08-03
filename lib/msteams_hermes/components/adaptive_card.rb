# frozen_string_literal: true

require "msteams_hermes/components/base"

module MsTeamsHermes
  module Components
    ##
    # https://adaptivecards.io/explorer/AdaptiveCard.html
    ##
    class AdaptiveCard < Base
      def initialize(args)
        super

        @body = args[:body]
        raise "AdaptiveCard `body` cannot be empty" if @body.nil?
        raise "AdaptiveCard `body` must be an Array" unless @body.is_a? Array
      end

      def to_hash
        {
          type: "AdaptiveCard",
          version: "1.5",
          body: @body.map(&:to_hash)
        }
      end
    end
  end
end
