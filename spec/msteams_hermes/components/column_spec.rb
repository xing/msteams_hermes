# frozen_string_literal: true

require "msteams_hermes/components/column"
require "msteams_hermes/components/fact_set"

RSpec.describe MsTeamsHermes::Components::Column do
  describe "#initialize" do
    it "throws an error if items is not an Array" do
      expect do
        MsTeamsHermes::Components::Column.new(items: "foo")
      end.to raise_error("Column `items` must be an Array")
    end
  end

  describe "#to_hash" do
    subject(:component) { MsTeamsHermes::Components::Column.new(items: [fact_set], width:) }

    let(:fact_set) { MsTeamsHermes::Components::FactSet.new(facts: [fact]) }
    let(:fact) { { title: "foo", value: "bar" } }
    let(:width) { "50px" }

    it "renders the hash object" do
      hash = {
        type: "Column",
        items: [
          {
            type: "FactSet",
            facts: [fact]
          }
        ],
        width:
      }

      expect(component.to_hash).to eq hash
    end
  end
end
