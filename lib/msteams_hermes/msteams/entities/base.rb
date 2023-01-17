# lib/base.rb

module MsTeamsHermes
  module MsTeams
    module Entities
      # Super class for entities to enforce overridding the `to_hash` method
      class Base
        def to_hash
          raise "Should be implemented on the subclass"
        end
      end
    end
  end
end
