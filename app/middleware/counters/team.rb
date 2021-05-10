# frozen_string_literal: true

module Counters
  class Team
    class << self
      def add_employee(team_id)
        ::Team.increment_counter(:employees_count, team_id)
      end

      def remove_employee(team_id)
        ::Team.decrement_counter(:employees_count, team_id)
      end

      def add_feedback(team_id)
        ::Team.increment_counter(:comments, team_id)
      end

      def add_given_high5(team_id)
        ::Team.increment_counter(:high5_given, team_id)
      end

      def add_received_high5(team_id)
        ::Team.increment_counter(:high5_received, team_id)
      end

      def add_result(result_field, team_id)
        ::Team.increment_counter(result_field, team_id)
        ::Team.increment_counter(:feedback_given, team_id)
      end
    end
  end
end
