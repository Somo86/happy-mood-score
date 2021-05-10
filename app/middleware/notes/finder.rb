# frozen_string_literal: true

module Notes
  class Finder
    def initialize(employee, params)
      @params = params
      @employee = employee
    end

    def all
      apply_filters
      notes.order(:receiver_id, :updated_at)
    end

    private

    attr_reader :employee, :params, :notes

    def apply_filters
      return if params[:receiver_id].blank?

      @notes = notes.where(receiver_id: params[:receiver_id])
    end

    def notes
      @notes ||= params[:closed].to_i == 1 ? employee.notes.closed : employee.notes.active
    end
  end
end
