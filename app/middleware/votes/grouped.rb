# frozen_string_literal: true

module Votes
  class Grouped
    def initialize(grouped_votes)
      @grouped_votes = grouped_votes
    end

    def count
      {
        hms: hms,
        involvement: involvement,
        total_bad: total_bad,
        total_fine: total_fine,
        total_good: total_good,
      }
    end

    private

    attr_reader :grouped_votes

    def hms
      metrics[0]
    end

    def involvement
      metrics[1]
    end

    def metrics
      @metrics ||= Dashboards::Hms.new(bad: total_bad, fine: total_fine, good: total_good, total: total_count).calculate
    end

    def total_bad
      grouped_votes[10].to_i
    end

    def total_count
      grouped_votes.values.sum
    end

    def total_fine
      grouped_votes[20].to_i
    end

    def total_good
      grouped_votes[30].to_i
    end

    def total_votes
      total_bad + total_fine + total_good
    end
  end
end
