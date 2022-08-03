# frozen_string_literal: true

require "msteams_hermes/style"

module MsTeamsHermes
  module Components
    class ColumnSet < Base
      def initialize(args)
        super
        @columns = args[:columns]

        raise "ColumnSet `columns` cannot be empty" if @columns.nil?
        raise "ColumnSet `columns` must be an Array" unless @columns.is_a? Array
      end

      def to_hash
        {
          type: "ColumnSet",
          columns: @columns.map(&:to_hash)
        }
      end
    end
  end
end
