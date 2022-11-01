# frozen_string_literal: true

require "msteams_hermes/components/base"
require "msteams_hermes/style"

module MsTeamsHermes
  ##
  # Module containing Microsoft's components representations
  ##
  module Components
    ##
    # A class representing Microsoft's ActionSet object
    # https://adaptivecards.io/explorer/ActionSet.html
    ##
    class ActionSet < Base
      attr_reader :actions

      def initialize(actions:)
        @actions = actions
        raise "ActionSet `actions` must be an Array" unless @actions.is_a? Array
      end

      def to_hash
        {
          type: "ActionSet",
          actions: actions.map(&:to_hash)
        }
      end
    end
  end
end
