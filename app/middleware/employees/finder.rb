# frozen_string_literal: true

module Employees
  class Finder
    def initialize(company, params)
      @company = company
      @params = params
      Rails.logger.info params
    end

    def all
      apply_filters

      employees.order(:name)
    end

    private

    attr_reader :company, :params

    def apply_filters
      filter_active
      filter_name
      filter_team
    end

    def employees
      @employees ||= company.employees.includes(:team, :user)
    end

    def filter_active
      @employees = params[:archived].to_i == 1 ? employees.archived : employees.active
    end

    def filter_name
      return unless params[:name].present?

      @employees = employees.where(name_search).or(email_search)
    end

    def filter_team
      return unless params[:team_id].present?

      @employees = employees.where(team_id: params[:team_id])
    end

    def name_search
      name = Employee.arel_table[:name]
      name.matches("%#{params[:name]}%")
    end

    def email_search
      email = Employee.arel_table[:email]
      Employee.where(email.matches("%#{params[:name]}%"))
    end
  end
end
