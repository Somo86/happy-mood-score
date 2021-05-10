# frozen_string_literal: true

module Dashboards
  class Main
    class << self
      def generate(employee)
        new(employee).generate
      end
    end

    def initialize(employee)
      @employee = employee
    end

    def generate
      {
        trends: Employees::Trends.generate(employee)
      }.merge(employee_gauge)
    end

    private

    attr_reader :employee

    def employee_gauge
      Dashboards::Gauge.new(employee).generate
    end
  end
end
