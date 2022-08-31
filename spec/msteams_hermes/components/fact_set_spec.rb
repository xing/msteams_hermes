# frozen_string_literal: true

require "msteams_hermes/components/fact_set"

RSpec.describe MsTeamsHermes::Components::FactSet do
  describe "#initialize" do
    it "throws an error if facts is not provided" do
      expect do
        MsTeamsHermes::Components::FactSet.new(foo: "bar")
      end.to raise_error("FactSet `facts` cannot be empty")
    end

    it "throws an error if facts is not an Array" do
      expect do
        MsTeamsHermes::Components::FactSet.new(facts: { title: "foo", value: "bar" })
      end.to raise_error("FactSet `facts` must be an Array of hashes containing title and value keys")
    end

    it "throws an error if any fact doesn't contain the proper keys" do
      expect do
        MsTeamsHermes::Components::FactSet.new(
          facts: [
            { title: "foo", value: "bar" },
            { title: "foo", value: "bar", any: "value" },
            { title: "foo", value: "bar" },
            { title: "foo" }
          ]
        )
      end.to raise_error("FactSet `facts` must be an Array of hashes containing title and value keys")
    end
  end

  describe "#to_hash" do
    subject(:component) { MsTeamsHermes::Components::FactSet.new(facts: [fact]) }

    let(:fact) { { title: "foo", value: "bar" } }

    it "renders the hash object" do
      expect(component.to_hash).to eq({ type: "FactSet", facts: [fact] })
    end
  end
end
