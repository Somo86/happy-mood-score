# frozen_string_literal: true

module Dashboards
  class Hms
    def initialize(votes)
      @bad = votes.fetch(:bad, 0).to_f
      @fine = votes.fetch(:fine, 0).to_f
      @good = votes.fetch(:good, 0).to_f
      @total = votes.fetch(:total, 0).to_f
    end

    def calculate
      return [0, 0] if total_votes.zero?

      [hms.round, involvement.round]
    end

    private

    attr_reader :bad, :fine, :good, :total

    def hms
      (sum_value / (total_votes * 2)) * 10
    end

    def involvement
      (total_votes / total) * 100
    end

    def sum_value
      fine + good * 2 - bad * 2
    end

    def total_votes
      bad + fine + good
    end
  end
end
