# frozen_string_literal: true

module Logs
  class Employee
    class << self
      def update(start_date, end_date, employee)
        new(start_date, end_date, employee).update
      end
    end

    def initialize(start_date, end_date, employee)
      @start_date = start_date
      @end_date = end_date
      @employee = employee
    end

    def update
      update_log(total_votes, total_high5)
    end

    private

    attr_reader :start_date, :end_date, :employee

    def update_log(votes, high5s)
      employee.historical_logs.create(
        results_bad: votes[:bad],
        results_fine: votes[:fine],
        results_good: votes[:good],
        total_votes: votes[:total_votes],
        total_count: votes[:total],
        total_pending: votes[:total_pending],
        comments: votes[:with_comments],
        hms: employee.hms,
        involvement: employee.involvement,
        points: employee.points,
        level_name: employee.level_name,
        feedback_given: votes[:total_votes],
        high5_received: high5s[:high5_received],
        high5_given: high5s[:high5_given],
        generated_on: start_date,
        company_ranking: 0,
        team_ranking: 0
      )
    end

    def total_votes
      result = {}
      result[:good] = employee.votes.good.where(generated_at: start_date..end_date).count
      result[:fine] = employee.votes.fine.where(generated_at: start_date..end_date).count
      result[:bad] = employee.votes.bad.where(generated_at: start_date..end_date).count
      result[:total] = employee.votes.where(generated_at: start_date..end_date).count
      result[:with_comments] = employee.votes.with_comments.where(generated_at: start_date..end_date).count
      result[:total_votes] = result[:good] + result[:fine] + result[:bad]
      result[:total_pending] = result[:total] - result[:total_votes]

      result
    end

    def total_high5
      result = {}
      result[:high5_given] = high5.activities.where(sender_id: employee.id).within_period(start_date, end_date).count
      result[:high5_received] = high5.activities.where(employee_id: employee.id).within_period(start_date, end_date).count

      result
    end

    def company
      employee.company
    end

    def high5
      company.events.high5.first
    end
  end
end
