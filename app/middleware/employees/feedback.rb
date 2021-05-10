# frozen_string_literal: true

module Employees
  class Feedback
    class << self
      def request(company)
        company.employees.active.each do |employee|
          vote = employee.votes.create!(generated_at: company.next_request_at)

          if employee.slack_enabled?
            Slack::Feedback.request(vote)
          else
            FeedbackMailer.request_email(employee, vote.token)
          end
        end
      end
    end
  end
end
