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
    # A class representing Microsoft's Container object
    # https://adaptivecards.io/explorer/Container.html
    ##
    class Container < Base
      attr_reader :items, :style, :select_action

      def initialize(items:, style: Style::ContainerStyle::DEFAULT, select_action: nil)
        @items = items
        raise "Container `items` must be an Array" unless @items.is_a? Array

        @style = style
        @select_action = select_action
      end

      def to_hash
        {
          type: "Container",
          style:,
          selectAction: select_action&.to_hash,
          items: items.map(&:to_hash)
        }
      end
    end
  end
end
