# frozen_string_literal: true

require "msteams_hermes/actions/base"

module MsTeamsHermes
  module Actions
    class OpenUrl < Base
      def initialize(args)
        super

        @url = args[:url]
        raise "OpenUrl `url` cannot be empty" if @url.nil?

        @title = args[:title]
        @tooltip = args[:tooltip]
      end

      def to_hash
        {
          type: "Action.OpenUrl",
          url: @url,
          title: @title,
          tooltip: @tooltip
        }
      end
    end
  end
end
