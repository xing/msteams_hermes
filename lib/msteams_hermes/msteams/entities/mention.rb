# frozen_string_literal: true

require "msteams_hermes/msteams/entities/base"

module MsTeamsHermes
  module MsTeams
    module Entities
      ##
      # A class representing Microsoft's Msteams.Mention object
      # https://learn.microsoft.com/en-us/microsoftteams/platform/task-modules-and-cards/cards/cards-format?tabs=adaptive-md%2Cdesktop%2Cconnector-html#user-mention-in-incoming-webhook-with-adaptive-cards
      ##
      class Mention < Base

        def initialize(text:, name:, id:)
          @mention_reference = text # String surrounded by <at>string</at> that marks the mention section in a text
          @mention_string = name # allows for overriding the mention_reference
          @user_id = id
        end

        def to_hash
          {
            type: "mention",
            text: @mention_reference,
            mentioned: {
              id: @user_id,
              name: @mention_string
            }
          }
        end
      end
    end
  end
end
