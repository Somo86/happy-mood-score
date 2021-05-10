# frozen_string_literal: true

module Activities
  class Vote
    class << self
      def new_result(vote)
        event = vote.company.events.vote.first
        activity = vote.employee.activities.create(event: event)
        Counters::Update.new_result(vote)

        activity
      end

      def new_feedback(vote)
        event = vote.company.events.feedback.first
        activity = vote.employee.activities.create(event: event)
        Counters::Update.new_feedback(vote)

        activity
      end
    end
  end
end
