# frozen_string_literal: true

require "msteams_hermes/style"

module MsTeamsHermes
  module Components
    class Column < Base
      def initialize(args)
        super

        @items = args[:items]
        raise "Column `items` cannot be empty" if @items.nil?
        raise "Column `items` must be an Array" unless @items.is_a? Array

        @width = args[:width] || "auto"
      end

      def to_hash
        {
          type: "Column",
          width: @width,
          items: @items.map(&:to_hash)
        }
      end
    end
  end
end
