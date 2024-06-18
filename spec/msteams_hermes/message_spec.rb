# frozen_string_literal: true

require "msteams_hermes/message"
require "msteams_hermes/components/adaptive_card"
require "msteams_hermes/components/fact_set"
require "msteams_hermes/style"

RSpec.describe MsTeamsHermes::Message do
  let(:fact) { { title: "foo", value: "bar" } }
  let(:fact_set) { MsTeamsHermes::Components::FactSet.new(facts: [fact]) }
  let(:card) { MsTeamsHermes::Components::AdaptiveCard.new(body: [fact_set]) }

  let(:webhook_url) { "https://some-company.webhook.office.com/webhookb2/some-more-path-tokens" }

  describe "#initialize" do
    it "throws an error if webhook_url is not provided" do
      expect do
        MsTeamsHermes::Message.new(content: MsTeamsHermes::Components::AdaptiveCard.new(body: ["any"]))
      end.to raise_error("Message `webhook_url` cannot be empty")
    end

    it "throws an error if content is not an AdaptiveCard" do
      expect do
        MsTeamsHermes::Message.new(webhook_url: "any", content: "any")
      end.to raise_error("Message `content` must be an AdaptiveCard")
    end

    it "does not throw an error if webhook_url is set as environment variable" do
      ENV["WEBHOOK_URL"] = "any"

      expect do
        MsTeamsHermes::Message.new(content: MsTeamsHermes::Components::AdaptiveCard.new(body: ["any"]))
      end.not_to raise_error
    end
  end

  describe "#deliver" do
    subject { MsTeamsHermes::Message.new(webhook_url:, content: card).deliver }

    before do
      stub_request(:post, webhook_url).to_return(status: 200, body: webhook_response_body, headers: {})
    end

    context "when microsoft teams answer includes 413 error message" do
      let(:webhook_response_body) do
        "some prefix #{MsTeamsHermes::Message::MSTEAMS_MESSAGE_413_ERROR_TOKEN} some suffix"
      end

      it "raises an error if the body size is too big" do
        expect { subject }.to raise_error(MsTeamsHermes::Message::MessageBodyTooLargeError)
      end
    end

    context "when microsoft teams answer with an unexpected response body" do
      let(:webhook_response_body) { "something unexpected" }

      it "raises an error if the body size is too big" do
        expect { subject }.to raise_error(MsTeamsHermes::Message::UnknownError)
      end
    end

    context "when network call is successful" do
      let(:webhook_response_body) { "1" }

      it "returns the network call response instance" do
        expect(subject).to be_a Net::HTTPOK
      end
    end
  end

  describe "#body_json" do
    subject(:message) { MsTeamsHermes::Message.new(webhook_url:, content: card) }

    it "sends the POST request with the formatted body" do
      hash = {
        type: "message",
        attachments: [
          {
            contentType: "application/vnd.microsoft.card.adaptive",
            contentUrl: nil,
            content: {
              type: "AdaptiveCard",
              version: "1.5",
              body: [
                {
                  type: "FactSet",
                  facts: [fact]
                }
              ],
              actions: nil,
              msteams: {
                entities: [],
                width: "default"
              }
            }
          }
        ]
      }

      expect(message.body_json).to eq(hash.to_json)
    end
  end
end
