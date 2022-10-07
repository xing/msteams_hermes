# frozen_string_literal: true

require "msteams_hermes/components/base"

module MsTeamsHermes
  ##
  # Module containing Microsoft's components representations
  ##
  module Components
    ##
    # Base class of Components representations
    ##
    class Base
      def to_hash
        raise "Should be implemented on the subclass"
      end
    end
  end
end
