# frozen_string_literal: true

module MsTeamsHermes
  ##
  # Module containing Microsoft's style representations
  ##
  module Style
    ##
    # Module containing Microsoft's ContainerStyle representation
    # See `ContainerStyle` in https://adaptivecards.io/explorer/Container.html
    ##
    module ContainerStyle
      DEFAULT = "default"
      ACCENT = "accent"
      GOOD = "good"
      WARNING = "warning"
      ATTENTION = "attention"
      EMPHASIS = "emphasis"
    end
  end
end
