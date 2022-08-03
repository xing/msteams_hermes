# frozen_string_literal: true

require "msteams_hermes/style"

module MsTeamsHermes
  module Components
    include MsTeamsHermes::Style

    class Container < Base
      def initialize(args)
        super
        @items = args[:items]

        raise "Container `items` cannot be empty" if @items.nil?
        raise "Container `items` must be an Array" unless @items.is_a? Array

        @style = args[:style] || Style::Colors::DEFAULT
      end

      def to_hash
        {
          type: "Container",
          style: @style,
          items: @items.map(&:to_hash)
        }
      end
    end
  end
end