# frozen_string_literal: true

require "msteams_hermes/msteams/entities/mention"

RSpec.describe MsTeamsHermes::MsTeams::Entities::Mention do
  describe "#initialize" do
    it "throws an error if text parameter does not contain <at> and </at>" do
      expect do
        MsTeamsHermes::MsTeams::Entities::Mention.new(text: "foo", name: "something", id: "123")
      end.to raise_error("`text` must contain <at>...</at>")
    end
  end

  describe "#to_hash" do
    subject(:mention) do
      MsTeamsHermes::MsTeams::Entities::Mention.new(text: mention_segment_in_text,
                                                    name: mention_string,
                                                    id: user_id)
    end

    let(:mention_segment_in_text) { "<at>original text reference</at>" }
    let(:user_id) { "aneamailaddress@yourcompany.com" }
    let(:mention_string) { "Text to show up as mention" }

    it "renders the hash object" do
      expected_hash = {
        type: "mention",
        text: mention_segment_in_text,
        mentioned: {
          id: user_id,
          name: mention_string
        }
      }

      expect(mention.to_hash).to eq(expected_hash)
    end
  end
end
