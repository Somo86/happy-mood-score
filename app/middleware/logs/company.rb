# frozen_string_literal: true

module Logs
  class Company
    class << self
      def update(start_date, end_date, company)
        new(start_date, end_date, company).update
      end
    end

    def initialize(start_date, end_date, company)
      @start_date = start_date
      @end_date = end_date
      @company = company
    end

    def update
      update_log(total_votes, total_high5)
    end

    private

    attr_reader :start_date, :end_date, :company

    def update_log(votes, high5s)
      company.historical_logs.create(
        results_bad: votes[:bad],
        results_fine: votes[:fine],
        results_good: votes[:good],
        total_votes: votes[:total_votes],
        total_count: votes[:total],
        total_pending: votes[:total_pending],
        comments: votes[:with_comments],
        hms: company.hms,
        involvement: company.involvement,
        feedback_given: votes[:total_votes],
        high5_received: high5s[:high5_received],
        high5_given: high5s[:high5_given],
        generated_on: start_date
      )
    end

    def total_votes
      result = {}
      result[:good] = company.votes.good.where(generated_at: start_date..end_date).count
      result[:fine] = company.votes.fine.where(generated_at: start_date..end_date).count
      result[:bad] = company.votes.bad.where(generated_at: start_date..end_date).count
      result[:total] = company.votes.where(generated_at: start_date..end_date).count
      result[:with_comments] = company.votes.with_comments.where(generated_at: start_date..end_date).count
      result[:total_votes] = result[:good] + result[:fine] + result[:bad]
      result[:total_pending] = result[:total] - result[:total_votes]

      result
    end

    def total_high5
      result = {}
      result[:high5_given] = high5.activities.where(sender_id: company_employee_ids).within_period(start_date, end_date).count
      result[:high5_received] = high5.activities.where(employee_id: company_employee_ids).within_period(start_date, end_date).count

      result
    end

    def high5
      company.events.high5.first
    end

    def company_employee_ids
      company.employees.active.pluck(:id)
    end
  end
end
