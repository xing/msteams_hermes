# frozen_string_literal: true

require "msteams_hermes/style/colors"
require "msteams_hermes/style/container_style"
require "msteams_hermes/style/font_size"
require "msteams_hermes/style/font_type"
require "msteams_hermes/style/font_weight"

module MsTeamsHermes
  module Style
    include MsTeamsHermes::Style::Colors
    include MsTeamsHermes::Style::ContainerStyle
    include MsTeamsHermes::Style::FontSize
    include MsTeamsHermes::Style::FontType
    include MsTeamsHermes::Style::FontWeight
  end
end
