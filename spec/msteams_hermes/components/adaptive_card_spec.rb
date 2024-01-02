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
    let(:fact_set) { MsTeamsHermes::Components::FactSet.new(facts: [fact]) }
    let(:action) { MsTeamsHermes::Actions::OpenUrl.new(url: action_url) }
    let(:fact) { { title: "foo", value: "bar" } }
    let(:action_url) { "any_url" }

    context "with full width" do
      subject(:component) do
        MsTeamsHermes::Components::AdaptiveCard.new(body: [fact_set], actions: [action], full_width: true)
      end

      it "renders the hash object with full width" do
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
          msteams: {
            entities: [],
            width: "full"
          }
        }

        expect(component.to_hash).to eq hash
      end
    end

    context "with not full width" do
      subject(:component) do
        MsTeamsHermes::Components::AdaptiveCard.new(body: [fact_set], actions: [action], full_width: false)
      end

      it "renders the hash object with default width" do
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
          msteams: {
            entities: [],
            width: "default"
          }
        }

        expect(component.to_hash).to eq hash
      end
    end
  end
end
