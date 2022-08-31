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
      def initialize(args)
        super

        @items = args[:items]
        raise "Container `items` cannot be empty" if @items.nil?
        raise "Container `items` must be an Array" unless @items.is_a? Array

        @style = args[:style] || Style::ContainerStyle::DEFAULT
        @select_action = args[:select_action]
      end

      def to_hash
        {
          type: "Container",
          style: @style,
          selectAction: @select_action&.to_hash,
          items: @items.map(&:to_hash)
        }
      end
    end
  end
end
