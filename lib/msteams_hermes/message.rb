# frozen_string_literal: true

require "net/http"
require "json"

module MsTeamsHermes
  class Message
    def initialize(args)
      @webhook_url = ENV["WEBHOOK_URL"] || args[:webhook_url]
      @content = args[:content]

      raise "Message `webhook_url` cannot be empty" if @webhook_url.nil?
      raise "Message `content` cannot be empty" if @content.nil?
      raise "Message `content` must be an AdaptiveCard" unless @content.is_a? Components::AdaptiveCard
    end

    def deliver
      puts body_json
    end

    private

    def body_json
      {
        type: "message",
        attachments: [
          {
            contentType: "application/vnd.microsoft.card.adaptive",
            contentUrl: nil,
            content: @content.to_hash
          }
        ]
      }.to_json
    end
  end
end
