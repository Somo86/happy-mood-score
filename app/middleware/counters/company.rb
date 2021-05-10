# frozen_string_literal: true

module Counters
  class Company
    class << self
      def add_feedback(company_id)
        ::Company.increment_counter(:comments, company_id)
      end

      def add_high5(company_id)
        ::Company.increment_counter(:high5_total, company_id)
      end

      def add_result(result_field, company_id)
        ::Company.increment_counter(result_field, company_id)
        ::Company.increment_counter(:feedback_given, company_id)
      end
    end
  end
end
