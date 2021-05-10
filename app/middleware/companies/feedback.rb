# frozen_string_literal: true

module Companies
  class Feedback
    class << self
      def request
        Company.active.with_request_enabled.where(next_request_at: start_time..end_time).each do |company|
          Employees::Feedback.request(company)

          next_delivery_date = Jobs::Dates.new(company).next_request
          company.update(next_request_at: next_delivery_date)
        end
      end

      def start_time
        5.minutes.ago.beginning_of_minute
      end

      def end_time
        5.minutes.from_now.end_of_minute
      end
    end
  end
end
