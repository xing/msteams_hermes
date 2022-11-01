# frozen_string_literal: true

require "msteams_hermes/components/action_set"
require "msteams_hermes/actions/open_url"

RSpec.describe MsTeamsHermes::Components::ActionSet do
  describe "#initialize" do
    it "throws an error if actions is not an Array" do
      expect do
        MsTeamsHermes::Components::ActionSet.new(actions: "foo")
      end.to raise_error("ActionSet `actions` must be an Array")
    end
  end

  describe "#to_hash" do
    subject(:component) { MsTeamsHermes::Components::ActionSet.new(actions: [action]) }

    let(:action) { MsTeamsHermes::Actions::OpenUrl.new(title: "Some Title", url: "https://someurl.com") }

    it "renders the hash object" do
      hash = {
        type: "ActionSet",
        actions: [
          {
            type: "Action.OpenUrl",
            url: "https://someurl.com",
            title: "Some Title",
            tooltip: nil
          }
        ]
      }

      expect(component.to_hash).to eq hash
    end
  end
end
