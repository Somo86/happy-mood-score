# frozen_string_literal: true

module Counters
  class Employee
    class << self
      def add_feedback(employee_id)
        ::Employee.increment_counter(:comments, employee_id)
      end

      def add_given_high5(employee_id)
        ::Employee.increment_counter(:high5_given, employee_id)
      end

      def add_received_high5(employee_id)
        ::Employee.increment_counter(:high5_received, employee_id)
      end

      def add_result(result_field, employee_id)
        ::Employee.increment_counter(result_field, employee_id)
        ::Employee.increment_counter(:feedback_given, employee_id)
      end
    end
  end
end
