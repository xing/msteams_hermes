# frozen_string_literal: true

require "msteams_hermes/style/colors"
require "msteams_hermes/style/container_style"
require "msteams_hermes/style/font_size"
require "msteams_hermes/style/font_type"
require "msteams_hermes/style/font_weight"
require "msteams_hermes/style/width"

module MsTeamsHermes
  ##
  # Module containing Microsoft's style representations
  ##
  module Style
    include MsTeamsHermes::Style::Colors
    include MsTeamsHermes::Style::ContainerStyle
    include MsTeamsHermes::Style::FontSize
    include MsTeamsHermes::Style::FontType
    include MsTeamsHermes::Style::FontWeight
    include MsTeamsHermes::Style::Width
  end
end
