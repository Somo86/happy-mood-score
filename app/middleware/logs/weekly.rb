# frozen_string_literal: true

module Logs
  class Weekly
    class << self
      def generate(date=Date.current)
        new(date).generate
      end
    end

    def initialize(date)
      @start_date = date.beginning_of_week
      @end_date = date.end_of_week
    end

    def generate
      ::Company.active.each { |company| update_logs(company) }
    end

    private

    attr_reader :start_date, :end_date

    def update_logs(company)
      company.employees.active.each { |employee| Logs::Employee.update(start_date, end_date, employee) }
      company.teams.with_employees.each do |team|
        Logs::Team.update(start_date, end_date, team)
        Logs::Ranking.update_team(start_date, team)
      end
      Logs::Company.update(start_date, end_date, company)
      Logs::Ranking.update_company(start_date, company)
    end
  end
end

