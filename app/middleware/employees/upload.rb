# frozen_string_literal: true

require 'csv'

module Employees
  class Upload
    def initialize(file, current_employee)
      @file = file
      @current_employee = current_employee
      @errors = []
    end

    def import
      CSV.foreach(file, headers: false) do |row|
        create_employee(row) if row.size >= 2
      end

      errors
    end

    private

    attr_reader :file, :current_employee, :errors

    def create_employee(employee)
      new_employee = company.employees.create(
        email: employee[0],
        name: employee[1],
        language: company.language,
        team: find_team(employee)
      )
      @errors << employee unless new_employee.valid?
    end

    def find_team(employee)
      team = company.teams.find_or_create_by(name: employee[2]) if employee[2].present?

      team || company.teams.first
    end

    def company
      current_employee.company
    end
  end
end
