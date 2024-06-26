# frozen_string_literal: true

require "msteams_hermes/actions/open_url"

RSpec.describe MsTeamsHermes::Actions::OpenUrl do
  describe "#to_hash" do
    subject(:action) { MsTeamsHermes::Actions::OpenUrl.new(url:, title:, tooltip:) }

    let(:url) { "https://foo" }
    let(:title) { "any title" }
    let(:tooltip) { "any tooltip" }

    it "renders the hash object" do
      expect(action.to_hash).to eq({ type: "Action.OpenUrl", url:, title:, tooltip: })
    end
  end
end
