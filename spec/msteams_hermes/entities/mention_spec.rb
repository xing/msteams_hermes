# frozen_string_literal: true

require "msteams_hermes/msteams/entities/mention"

RSpec.describe MsTeamsHermes::MsTeams::Entities::Mention do
  describe "#initialize" do
    it "throws an error if text paramter does not contain <at> and </at>" do
      expect do
        MsTeamsHermes::MsTeams::Entities::Mention.new(text: "foo", name: "something", id: "123")
      end.to raise_error("`text` must contain <at>...</at>")
    end
  end
end
