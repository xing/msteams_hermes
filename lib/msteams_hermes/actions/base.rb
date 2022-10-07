# frozen_string_literal: true

require "msteams_hermes/components/base"

module MsTeamsHermes
  module Actions
    ##
    # Base class of Actions representations
    ##
    class Base
      def to_hash
        raise "Should be implemented on the subclass"
      end
    end
  end
end
