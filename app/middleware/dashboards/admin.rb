# frozen_string_literal: true

module Dashboards
  class Admin
    class << self
      def generate(company)
        new(company).generate
      end
    end

    def initialize(company)
      @company = company
    end

    def generate
      {
        total_high5: company.high5_total,
        weekly_high5: log.high5_total,
        total_comments: company.comments,
        weekly_comments: log.comments
      }.merge(company_gauge)
    end

    private

    attr_reader :company

    def company_gauge
      Dashboards::Gauge.new(company).generate
    end

    def log
      company.last_log
    end
  end
end
