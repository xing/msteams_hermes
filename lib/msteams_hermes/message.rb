# frozen_string_literal: true

require "net/http"
require "json"

##
# Module to encapsulate the logic that decides whether a given response
# is of type workflow or connector type webhook.
# Both types must be considered differently to support both types of
# MSTeams webhooks.
##
module MsTeamsWebhookType
end

module MsTeamsHermes
  ##
  # A class representing Microsoft's webhook message object
  # https://docs.microsoft.com/en-us/microsoftteams/platform/webhooks-and-connectors/how-to/connectors-using?tabs=cURL#send-adaptive-cards-using-an-incoming-webhook
  ##
  class Message
    ##
    # Raises when the message is larger than the latest known maximum size of a microsoft teams message
    ##
    class MessageBodyTooLargeError < StandardError
      def initialize(current_size)
        super "Microsoft Teams Webhook answered with a 413 due to content size limitations" \
              " (last check it was about #{MSTEAMS_MESSAGE_SIZE_LIMIT} bytes)." \
              "\nYour message results in a size of about #{current_size} bytes which is too much."
      end
    end

    ##
    # Raises when the response message changes from the successful response
    ##
    class UnknownError < StandardError
      def initialize(error)
        super "Microsoft Teams Webhook had an unexpected response body:\n#{error}"
      end
    end

    # Docu says: 'The message size limit is 28 KB',
    # but testing aligned with 21KB.
    # See: https://learn.microsoft.com/en-us/microsoftteams/platform/webhooks-and-connectors/how-to/add-incoming-webhook
    MSTEAMS_MESSAGE_SIZE_LIMIT = 21_000
    MSTEAMS_MESSAGE_413_ERROR_TOKEN = "returned HTTP error 413"

    attr_reader :webhook_url, :content

    def initialize(content:, webhook_url: ENV["WEBHOOK_URL"])
      @webhook_url = webhook_url
      @content = content

      raise "Message `webhook_url` cannot be empty" if @webhook_url.nil?
      raise "Message `content` must be an AdaptiveCard" unless @content.is_a? Components::AdaptiveCard
    end

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    ##
    # Sends a HTTP request to the webhook URL specified via
    # either environment variable or when initializing the class
    #
    # @return a Net::HTTP response object
    ##
    def deliver
      uri = URI.parse(webhook_url)
      Net::HTTP.start(uri.host, uri.port, use_ssl: true, verify_mode: OpenSSL::SSL::VERIFY_NONE) do |http|
        req = Net::HTTP::Post.new(uri)
        req.body = body_json
        req["Content-Type"] = "application/json"

        response = http.request(req)

        return response if response_from_mst_workflow_webhook?(response) ||
                           response_from_mst_connector_webhook?(response)

        raise MessageBodyTooLargeError, body_json.bytesize if message_too_large?(response)

        raise UnknownError, response.body
      end
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength

    ##
    # Formats the JSON object to be set on the HTTP request
    #
    # @return a JSON object
    ##
    def body_json
      {
        type: "message",
        attachments: [
          {
            contentType: "application/vnd.microsoft.card.adaptive",
            contentUrl: nil,
            content: content.to_hash
          }
        ]
      }.to_json
    end

    private

    def response_from_mst_workflow_webhook?(response)
      response.code == "202" and response.body.empty?
    end

    def response_from_mst_connector_webhook?(response)
      # For details see:
      # https://learn.microsoft.com/en-us/microsoftteams/platform/webhooks-and-connectors/how-to/connectors-using?tabs=cURL%2Ctext1#send-messages-using-curl-and-powershell
      response.code == "200" and response.body == "1"
    end

    def message_too_large?(response)
      response.body.include? MSTEAMS_MESSAGE_413_ERROR_TOKEN
    end
  end
end
