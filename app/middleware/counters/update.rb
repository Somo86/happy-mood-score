# frozen_string_literal: true

module Counters
  class Update
    class << self
      def new_feedback(vote)
        Employee.add_feedback(vote.employee.id)
        Team.add_feedback(vote.team.id)
        Company.add_feedback(vote.company.id)
      end

      def new_high5(sender, receiver)
        Employee.add_given_high5(sender.id)
        Employee.add_received_high5(receiver.id)
        Team.add_given_high5(sender.team.id)
        Team.add_received_high5(receiver.team.id)
        Company.add_high5(receiver.company.id)
      end

      def new_result(vote)
        updated_field = vote_result(vote.result)
        Employee.add_result(updated_field, vote.employee.id)
        Team.add_result(updated_field, vote.team.id)
        Company.add_result(updated_field, vote.company.id)
        Metrics.add_vote(vote)
      end

      private

      def vote_result(result)
        case result
        when 10
          :results_bad
        when 20
          :results_fine
        when 30
          :results_good
        end
      end
    end
  end
end
