# frozen_string_literal: true

module MsTeamsHermes
  ##
  # Module containing Microsoft's style representations
  ##
  module Style
    ##
    # Module containing available width options for the AdaptiveCard component
    ##
    module Width
      DEFAULT = "default"
      FULL = "full"

      def self.all
        [DEFAULT, FULL]
      end
    end
  end
end
