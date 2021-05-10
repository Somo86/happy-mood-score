# frozen_string_literal: true

module Feedback
  class Finder
    include Shared::Finders

    def initialize(employee, params)
      @employee = employee
      @params = params
    end

    def all
      filtered_votes

      results
    end

    private

    attr_reader :employee, :params

    def company
      employee.company
    end

    def filter_by_employee
      return unless params[:employee_id].present?

      @results = results.where(employee_id: params[:employee_id])
    end

    def filter_by_new
      return unless params[:new].to_i == 1

      @results = results.recent
    end

    def filter_by_status
      return if params[:all].to_i == 1

      @results = results.voted
    end

    def filter_by_team
      return unless params[:team_id].present?

      @results = results.where(team_id: params[:team_id])
    end

    def filtered_votes
      filter_by_status
      filter_by_team
      filter_by_employee
      filter_by_new
    end

    def results
      @results ||= company.votes.joins(:employee).includes(employee: :replies).where('employees.deleted_at IS NULL')
    end
  end
end
