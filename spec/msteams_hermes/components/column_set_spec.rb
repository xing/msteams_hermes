# frozen_string_literal: true

require "msteams_hermes/components/column"
require "msteams_hermes/components/column_set"
require "msteams_hermes/components/fact_set"

RSpec.describe MsTeamsHermes::Components::ColumnSet do
  describe "#initialize" do
    it "throws an error if columns is not provided" do
      expect do
        MsTeamsHermes::Components::ColumnSet.new(foo: "bar")
      end.to raise_error("ColumnSet `columns` cannot be empty")
    end

    it "throws an error if columns is not an Array" do
      expect do
        MsTeamsHermes::Components::ColumnSet.new(columns: "foo")
      end.to raise_error("ColumnSet `columns` must be an Array")
    end
  end

  describe "#to_hash" do
    subject(:component) { MsTeamsHermes::Components::ColumnSet.new(columns: [column]) }

    let(:column) { MsTeamsHermes::Components::Column.new(items: [fact_set]) }
    let(:fact_set) { MsTeamsHermes::Components::FactSet.new(facts: [fact]) }
    let(:fact) { { title: "foo", value: "bar" } }

    it "renders the hash object" do
      hash = {
        type: "ColumnSet",
        columns: [
          {
            type: "Column",
            items: [
              {
                type: "FactSet",
                facts: [fact]
              }
            ],
            width: "auto"
          }
        ]
      }

      expect(component.to_hash).to eq hash
    end
  end
end
