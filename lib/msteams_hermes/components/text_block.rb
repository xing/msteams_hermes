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
      def initialize(args)
        super

        init_attributes(args)
        raise "TextBlock `text` cannot be empty" if @text.nil?
        raise "TextBlock `text` must be a String" unless @text.is_a? String
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

      private

      def init_attributes(args)
        @text = args[:text]
        @wrap = args[:wrap] || false
        @color = args[:color] || Style::Colors::DEFAULT
        @size = args[:size] || Style::FontSize::DEFAULT
        @font_type = args[:font_type] || Style::FontType::DEFAULT
        @weight = args[:weight] || Style::FontWeight::DEFAULT
      end
    end
  end
end
