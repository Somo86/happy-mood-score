# frozen_string_literal: true

module Shared
  module Finders
    private

    def end_date
      @end_date ||= parse_date(params[:end_date])&.end_of_day
    end

    def filter_by_dates

      return unless start_date.present? || end_date.present?

      if start_date.present? && end_date.present?
        @results = results.where('activities.created_at': start_date..end_date)
      elsif start_date.present?
        @results = results.where('activities.created_at >= ?', start_date)
      else
        @results = results.where('activities.created_at <= ?', end_date)
      end
    end

    def parse_date(date)
      Date.parse(date)
    rescue
      nil
    end

    def start_date
      @start_date ||= parse_date(params[:start_date])&.beginning_of_day
    end
  end
end
