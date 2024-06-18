#!/usr/bin/env ruby
# frozen_string_literal: true

require "msteams_hermes/actions/open_url"
require "msteams_hermes/components/adaptive_card"
require "msteams_hermes/components/text_block"
require "msteams_hermes/components/container"
require "msteams_hermes/components/fact_set"
require "msteams_hermes/message"

YOUR_WEBHOOK_URL = "YOUR_WEBHOOK_URL"

header = MsTeamsHermes::Components::Container.new(
  style: MsTeamsHermes::Style::ContainerStyle::WARNING,
  items: [
    MsTeamsHermes::Components::TextBlock.new(
      text: "John Cena",
      size: MsTeamsHermes::Style::FontSize::LARGE,
      weight: MsTeamsHermes::Style::FontWeight::BOLDER
    ),
    MsTeamsHermes::Components::TextBlock.new(
      text: "Saturday, 1 January 2022"
    )
  ]
)

description = MsTeamsHermes::Components::TextBlock.new(
  text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et " \
        "dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip " \
        "ex ea commodo consequat.",
  wrap: true
)

facts = MsTeamsHermes::Components::FactSet.new(
  facts: [
    {
      "title": "Board:",
      "value": "Adaptive Card"
    },
    {
      "title": "List:",
      "value": "Backlog"
    },
    {
      "title": "Assigned to:",
      "value": "John Cena"
    },
    {
      "title": "Due date:",
      "value": "Not set"
    }
  ]
)

action = MsTeamsHermes::Actions::OpenUrl.new(
  title: "View Website",
  url: "https://adaptivecards.io"
)

content = MsTeamsHermes::Components::AdaptiveCard.new(
  body: [
    header,
    MsTeamsHermes::Components::Container.new(
      items: [
        description,
        facts
      ]
    )
  ],
  actions: [
    action
  ]
)

MsTeamsHermes::Message.new(webhook_url: YOUR_WEBHOOK_URL, content:).deliver
