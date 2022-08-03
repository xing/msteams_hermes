# frozen_string_literal: true

require "msteams_hermes/style"

module MsTeamsHermes
  module Components
    include MsTeamsHermes::Style

    ##
    # https://adaptivecards.io/explorer/TextBlock.html
    ##
    class TextBlock < Base
      def initialize(args)
        super

        @text = args[:text]
        raise "TextBlock `text` cannot be empty" if @text.nil?
        raise "TextBlock `text` must be a String" unless @text.is_a? String

        @wrap = args[:wrap] || false
        @color = args[:color] || Style::Colors::DEFAULT
        @size = args[:size] || Style::FontSize::DEFAULT
        @font_type = args[:font_type] || Style::FontType::DEFAULT
        @weight = args[:weight] || Style::FontWeight::DEFAULT
      end

      def to_hash
        {
          type: "TextBlock",
          text: @text,
          color: @color,
          size: @size,
          font_type: @font_type,
          weight: @weight,
          wrap: @wrap
        }
      end
    end
  end
end
