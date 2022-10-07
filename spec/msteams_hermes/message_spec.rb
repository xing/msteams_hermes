# frozen_string_literal: true

require "msteams_hermes/message"
require "msteams_hermes/components/adaptive_card"
require "msteams_hermes/components/fact_set"

RSpec.describe MsTeamsHermes::Message do
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

  describe "#body_json" do
    subject(:message) { MsTeamsHermes::Message.new(webhook_url: "webhook_url", content: card) }

    let(:card) { MsTeamsHermes::Components::AdaptiveCard.new(body: [fact_set]) }
    let(:fact_set) { MsTeamsHermes::Components::FactSet.new(facts: [fact]) }
    let(:fact) { { title: "foo", value: "bar" } }

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
              actions: nil
            }
          }
        ]
      }

      expect(message.body_json).to eq(hash.to_json)
    end
  end
end
