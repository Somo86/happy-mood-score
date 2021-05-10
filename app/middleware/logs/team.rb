module Logs
  class Team
    class << self
      def update(start_date, end_date, team)
        new(start_date, end_date, team).update
      end
    end

    def initialize(start_date, end_date, team)
      @start_date = start_date
      @end_date = end_date
      @team = team
    end

    def update
      update_log(total_votes, total_high5)
    end

    private

    attr_reader :start_date, :end_date, :team

    def update_log(votes, high5s)
      team.historical_logs.create(
        results_bad: votes[:bad],
        results_fine: votes[:fine],
        results_good: votes[:good],
        total_votes: votes[:total_votes],
        total_count: votes[:total],
        total_pending: votes[:total_pending],
        comments: votes[:with_comments],
        hms: team.hms,
        involvement: team.involvement,
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
      result[:good] = team.votes.good.where(generated_at: start_date..end_date).count
      result[:fine] = team.votes.fine.where(generated_at: start_date..end_date).count
      result[:bad] = team.votes.bad.where(generated_at: start_date..end_date).count
      result[:total] = team.votes.where(generated_at: start_date..end_date).count
      result[:with_comments] = team.votes.with_comments.where(generated_at: start_date..end_date).count
      result[:total_votes] = result[:good] + result[:fine] + result[:bad]
      result[:total_pending] = result[:total] - result[:total_votes]

      result
    end

    def total_high5
      result = {}
      result[:high5_given] = high5.activities.where(sender_id: team_employee_ids).within_period(start_date, end_date).count
      result[:high5_received] = high5.activities.where(employee_id: team_employee_ids).within_period(start_date, end_date).count

      result
    end

    def company
      team.company
    end

    def high5
      company.events.high5.first
    end

    def team_employee_ids
      team.employees.active.pluck(:id)
    end
  end
end
