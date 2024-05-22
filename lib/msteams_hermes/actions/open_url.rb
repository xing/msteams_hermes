# frozen_string_literal: true

require "msteams_hermes/actions/base"

module MsTeamsHermes
  module Actions
    ##
    # A class representing Microsoft's Action.OpenUrl object
    # https://adaptivecards.io/explorer/Action.OpenUrl.html
    ##
    class OpenUrl < Base
      attr_reader :url, :title, :tooltip

      def initialize(url:, title: nil, tooltip: nil)
        @url = url
        @title = title
        @tooltip = tooltip
      end

      def to_hash
        {
          type: "Action.OpenUrl",
          url:,
          title:,
          tooltip:
        }
      end
    end
  end
end
