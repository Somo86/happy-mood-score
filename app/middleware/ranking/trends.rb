# frozen_string_literal: true

module Ranking
  class Trends
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
        employee_ranking: employee_ranking,
        team_ranking: team_ranking,
        company_ranking: company_ranking
      }
    end

    private

    attr_reader :employee, :trends

    def company
      employee.company
    end

    def company_gauge
      Dashboards::Gauge.new(company, { hms_id: 'company-hms', involvement_id: 'company-inv' }).generate
    end

    def company_ranking
      {
        ranking: employee.last_log.company_ranking,
        total: company.last_log.active_employees
      }.merge(company_gauge)
    end

    def employee_ranking
      Dashboards::Gauge.new(employee).generate
    end

    def team
      employee.team
    end

    def team_gauge
      Dashboards::Gauge.new(team, { hms_id: 'team-hms', involvement_id: 'team-inv' }).generate
    end

    def team_ranking
      {
        ranking: employee.last_log.team_ranking,
        total: team.last_log.active_employees
      }.merge(team_gauge)
    end
  end
end
