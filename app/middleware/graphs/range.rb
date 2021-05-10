# frozen_string_literal: true

module Graphs
  class Range
    def initialize(company, start_date, end_date)
      @start_date = start_date
      @end_date = end_date
      @company = company
    end

    def by_month
      count.merge({ period: (I18n.t('date.month_names'))[start_date.month] })
    end

    def by_week
      count.merge({ period: I18n.l(start_date.to_date, format: :short) })
    end

    private

    attr_reader :start_date, :end_date, :company

    def count
      Votes::Grouped.new(votes).count
    end

    def votes
      company.votes.where(generated_at: start_date..end_date).group(:result).count
    end

  end
end
