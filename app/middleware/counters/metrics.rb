# frozen_string_literal: true

module Counters
  class Metrics
    class << self
      def add_vote(vote)
        update_employee(vote.employee)
        update_team(vote.team)
        update_company(vote.company)
      end

      private

      def update_employee(employee)
        grouped_votes = employee.votes.group(:result).count
        total = Votes::Grouped.new(grouped_votes).count
        employee.update(hms: total[:hms], involvement: total[:involvement])
      end

      def update_team(team)
        grouped_votes = team.votes.group(:result).count
        total = Votes::Grouped.new(grouped_votes).count
        team.update(hms: total[:hms], involvement: total[:involvement])
      end

      def update_company(company)
        grouped_votes = company.votes.group(:result).count
        total = Votes::Grouped.new(grouped_votes).count
        company.update(hms: total[:hms], involvement: total[:involvement])
      end
    end
  end
end
