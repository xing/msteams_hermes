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
        attr_reader :mention_reference, :mention_string, :user_id

        def initialize(text:, name:, id:)
          raise "`text` must be a string" unless text.is_a? String
          raise "`text` must contain <at>...</at>" unless text.include?("<at>") && text.include?("</at>")
          raise "`id` must be a string" unless text.is_a? String

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
