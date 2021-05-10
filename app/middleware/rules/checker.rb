# frozen_string_literal: true

module Rules
  class Checker
    attr_reader :employee, :rule

    def initialize(rule, employee)
      @rule = rule
      @employee = employee
    end

    def apply?
      return false if conditions.size.zero?

      conditions.all? { |condition| Conditions::Checker.new(condition, employee).apply? }
    end

    private

    def conditions
      rule.conditions
    end
  end
end
