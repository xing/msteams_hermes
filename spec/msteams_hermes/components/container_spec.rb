# frozen_string_literal: true

require "msteams_hermes/components/container"
require "msteams_hermes/components/fact_set"
require "msteams_hermes/actions/open_url"
require "msteams_hermes/style"

RSpec.describe MsTeamsHermes::Components::Container do
  describe "#initialize" do
    it "throws an error if items is not an Array" do
      expect do
        MsTeamsHermes::Components::Container.new(items: "foo")
      end.to raise_error("Container `items` must be an Array")
    end
  end

  describe "#to_hash" do
    subject(:component) do
      MsTeamsHermes::Components::Container.new(items: [fact_set],
                                               style: style,
                                               select_action: action)
    end

    let(:fact_set) { MsTeamsHermes::Components::FactSet.new(facts: [fact]) }
    let(:action) { MsTeamsHermes::Actions::OpenUrl.new(url: action_url) }
    let(:style) { MsTeamsHermes::Style::ContainerStyle::ACCENT }
    let(:fact) { { title: "foo", value: "bar" } }
    let(:action_url) { "any_url" }

    it "renders the hash object" do
      hash = {
        type: "Container",
        items: [
          {
            type: "FactSet",
            facts: [fact]
          }
        ],
        style: style,
        selectAction: {
          type: "Action.OpenUrl",
          url: action_url,
          title: nil,
          tooltip: nil
        }
      }

      expect(component.to_hash).to eq hash
    end
  end
end
