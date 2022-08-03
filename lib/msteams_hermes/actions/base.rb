# frozen_string_literal: true

require "msteams_hermes/components/base"

module MsTeamsHermes
  module Actions
    class Base
      def initialize(args); end

      def to_hash
        raise "Should be implemented on the subclass"
      end
    end
  end
end
