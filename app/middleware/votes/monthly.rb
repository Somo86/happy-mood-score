# frozen_string_literal: true

module Votes
  class Monthly
    def initialize(company, interval)
      @company = company
      @interval = interval
      @results = []
    end

    def generate
      {
        header: header,
        content: content
      }
    end

    private

    attr_reader :interval, :company
    attr_accessor :results

    def header
      {
        title: I18n.t('hmsTrends.monthlyTrends'),
        link: Rails.application.routes.url_helpers.global_admin_trends_path(period: 'weekly'),
        link_title: I18n.t('hmsTrends.showWeeks')
      }
    end

    def content
      votes
      {
        title_feedback: I18n.t('hmsTrends.feedback6Months'),
        title_hms: I18n.t('hmsTrends.hms6Months'),
        feedback: feedback_graph,
        hms: hms_graph
      }
    end

    def feedback_graph
      graph = Graphs::Feedback.new(results)
      {
        id: 'hms-graph',
        data: {
          labels: graph.labels,
          datasets: graph.datasets
        }
      }
    end

    def hms_graph
      graph = Graphs::Hms.new(results)
      {
        id: 'feedback-graph',
        data: {
          labels: graph.labels,
          datasets: graph.datasets
        }
      }
    end

    def votes
      start_month = interval
      while start_month > 0
        start_date = start_month.months.ago.beginning_of_month
        end_date = start_month.months.ago.end_of_month
        results << Graphs::Range.new(company, start_date, end_date).by_month
        start_month -= 1
      end
    end
  end
end
