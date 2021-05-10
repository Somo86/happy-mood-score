# frozen_string_literal: true

module Graphs
  class Hms
    def initialize(results)
      @results = results
    end

    def labels
      results.map { |result| result[:period] }
    end

    def datasets
      [ hms, involvement]
    end

    private

    attr_reader :results

    def hms
      {
        label: I18n.t('hmsTrends.hms'),
        data: results.map { |result| result[:hms] },
      }
    end

    def involvement
      {
        label: I18n.t('hmsTrends.involvement'),
        data: results.map { |result| result[:involvement] },
      }
    end
  end
end
