# frozen_string_literal: true

module Companies
  class Gamification
    class << self
      def setup!(company)
        Events::NewAccount.setup!(company)
        Rewards::NewAccount.setup!(company)
      end
    end
  end
end
