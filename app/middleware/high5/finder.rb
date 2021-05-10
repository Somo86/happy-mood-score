# frozen_string_literal: true

module High5
  class Finder
    include Shared::Finders

    def initialize(company, params)
      @company = company
      @params = params
    end

    def all
      filtered_high5s

      results
    end

    private

    attr_reader :company, :params

    def filter_by_sender
      return unless params[:sender_id].present?

      @results = results.where(sender_id: params[:sender_id])
    end

    def filter_by_receiver
      return unless params[:receiver_id].present?

      @results = results.where(employee_id: params[:receiver_id])
    end

    def filtered_high5s
      filter_by_sender
      filter_by_receiver
      filter_by_dates
    end

    def results
      @results ||= company.activities.high5s
    end
  end
end
