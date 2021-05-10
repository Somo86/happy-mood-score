# frozen_string_literal: true

module Votes
  class Trends
    class << self
      def monthly(company, months=5)
        Monthly.new(company, months).generate
      end

      def weekly(company, weeks=6)
        Weekly.new(company, weeks).generate
      end
    end
  end
end
