# frozen_string_literal: true

require "msteams_hermes/components/adaptive_card"
require "msteams_hermes/components/fact_set"
require "msteams_hermes/actions/open_url"

RSpec.describe MsTeamsHermes::Components::AdaptiveCard do
  describe "#initialize" do
    it "throws an error if body is not an Array" do
      expect do
        MsTeamsHermes::Components::AdaptiveCard.new(body: "foo")
      end.to raise_error("AdaptiveCard `body` must be an Array")
    end

    it "throws an error if actions is present and is not an Array" do
      expect do
        MsTeamsHermes::Components::AdaptiveCard.new(body: ["foo"], actions: "bar")
      end.to raise_error("AdaptiveCard `actions` must be an Array")
    end
  end

  describe "#to_hash" do
    subject(:component) { MsTeamsHermes::Components::AdaptiveCard.new(body: [fact_set], actions: [action]) }

    let(:fact_set) { MsTeamsHermes::Components::FactSet.new(facts: [fact]) }
    let(:action) { MsTeamsHermes::Actions::OpenUrl.new(url: action_url) }
    let(:fact) { { title: "foo", value: "bar" } }
    let(:action_url) { "any_url" }

    it "renders the hash object" do
      hash = {
        type: "AdaptiveCard",
        version: "1.5",
        body: [
          {
            type: "FactSet",
            facts: [fact]
          }
        ],
        actions: [
          {
            type: "Action.OpenUrl",
            url: action_url,
            title: nil,
            tooltip: nil
          }
        ],
        msteams: { entities: nil }
      }

      expect(component.to_hash).to eq hash
    end
  end
end
