# frozen_string_literal: true

require "msteams_hermes/components/base"
require "msteams_hermes/style"

module MsTeamsHermes
  ##
  # Module containing Microsoft's components representations
  ##
  module Components
    ##
    # A class representing Microsoft's Column object
    # https://adaptivecards.io/explorer/Column.html
    ##
    class Column < Base
      attr_reader :items, :width

      def initialize(items:, width: "auto")
        @items = items
        raise "Column `items` must be an Array" unless @items.is_a? Array

        @width = width
      end

      def to_hash
        {
          type: "Column",
          width: width,
          items: items.map(&:to_hash)
        }
      end
    end
  end
end
