# frozen_string_literal: true

module Employees
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
        high5_received: high5_received_trends,
        high5_given: high5_given_trends,
        hms: hms_trends,
        involvement: involvement_trends,
        comments: comments_trends,
        company_ranking: company_ranking,
        team_ranking: team_ranking,
        last_vote: last_vote
      }
    end

    private

    attr_reader :employee

    def comments_trends
      {
        total: last_log.comments,
        variation: last_log.comments - previous_log.comments
      }
    end

    def company
      @company ||= employee.company
    end

    def company_ranking
      {
        total: last_log.company_ranking,
        variation: (last_log.company_ranking - previous_log.company_ranking) * -1,
        hms: company.hms,
        involvement: company.involvement,
        total_employees: company.employees.active.size
      }
    end

    def high5_received_trends
      {
        total: last_log.high5_received,
        variation: last_log.high5_received - previous_log.high5_received
      }
    end

    def high5_given_trends
      {
        total: last_log.high5_given,
        variation: last_log.high5_given - previous_log.high5_given
      }
    end

    def hms_trends
      {
        total: last_log.hms,
        variation: last_log.hms - previous_log.hms
      }
    end

    def involvement_trends
      {
        total: last_log.involvement,
        variation: last_log.involvement - previous_log.involvement
      }
    end

    def last_vote
      employee.votes.voted.order(generated_at: :desc).first
    end

    def last_log
      @employee.historical_logs.order(generated_on: :desc).first || @employee.historical_logs.new
    end

    def previous_log
      @employee.historical_logs.order(generated_on: :desc).offset(1).first || @employee.historical_logs.new
    end

    def team
      @team ||= employee.team
    end

    def team_ranking
      {
        total: last_log.team_ranking,
        variation: (last_log.team_ranking - previous_log.team_ranking) * -1,
        hms: team.hms,
        involvement: team.involvement,
        total_employees: team.employees.active.size
      }
    end
  end
end
