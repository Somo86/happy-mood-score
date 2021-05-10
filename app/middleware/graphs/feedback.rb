# frozen_string_literal: true

module Graphs
  class Feedback
    def initialize(results)
      @results = results
    end

    def labels
      results.map { |result| result[:period] }
    end

    def datasets
      [ total_bad, total_fine, total_good ]
    end

    private

    attr_reader :results

    def total_bad
      {
        label: I18n.t('hmsTrends.bad'),
        data: results.map { |result| result[:total_bad] },
        borderColor: '#16c98d'
      }
    end

    def total_fine
      {
        label: I18n.t('hmsTrends.fine'),
        data: results.map { |result| result[:total_fine] },
        borderColor: '#ffc83f'
      }
    end

    def total_good
      {
        label: I18n.t('hmsTrends.happy'),
        data: results.map { |result| result[:total_good] },
        borderColor: '#fa5e5b'
      }
    end
  end
end
