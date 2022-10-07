# frozen_string_literal: true

require "msteams_hermes/components/base"
require "msteams_hermes/style"

module MsTeamsHermes
  ##
  # Module containing Microsoft's components representations
  ##
  module Components
    include MsTeamsHermes::Style
    ##
    # A class representing Microsoft's TextBlock object
    # https://adaptivecards.io/explorer/TextBlock.html
    ##
    class TextBlock < Base
      attr_reader :text, :wrap, :color, :size, :font_type, :weight

      def initialize(text:,
                     wrap: false,
                     color: Style::Colors::DEFAULT,
                     size: Style::FontSize::DEFAULT,
                     font_type: Style::FontType::DEFAULT,
                     weight: Style::FontWeight::DEFAULT)
        @text = text
        raise "TextBlock `text` must be a String" unless @text.is_a? String

        @wrap = wrap
        @color = color
        @size = size
        @font_type = font_type
        @weight = weight
      end

      def to_hash
        {
          type: "TextBlock",
          text: text,
          color: color,
          size: size,
          font_type: font_type,
          weight: weight,
          wrap: wrap
        }
      end
    end
  end
end
