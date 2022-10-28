# frozen_string_literal: true

require "msteams_hermes/components/text_block"
require "msteams_hermes/style"

RSpec.describe MsTeamsHermes::Components::TextBlock do
  describe "#initialize" do
    it "throws an error if text is not a String" do
      expect do
        MsTeamsHermes::Components::TextBlock.new(text: 123)
      end.to raise_error("TextBlock `text` must be a String")
    end
  end

  describe "#to_hash" do
    subject(:component) do
      MsTeamsHermes::Components::TextBlock.new(text: text,
                                               color: color,
                                               size: size,
                                               font_type: font_type,
                                               weight: weight,
                                               wrap: wrap,
                                               is_subtle: is_subtle)
    end

    let(:text) { "any text" }
    let(:color) { MsTeamsHermes::Style::Colors::GOOD }
    let(:size) { MsTeamsHermes::Style::FontSize::LARGE }
    let(:font_type) { MsTeamsHermes::Style::FontType::MONOSPACE }
    let(:weight) { MsTeamsHermes::Style::FontWeight::BOLDER }
    let(:wrap) { true }
    let(:is_subtle) { true }

    it "renders the hash object" do
      hash = {
        type: "TextBlock",
        text: text,
        color: color,
        size: size,
        font_type: font_type,
        weight: weight,
        wrap: wrap,
        is_subtle: is_subtle
      }

      expect(component.to_hash).to eq hash
    end
  end
end
