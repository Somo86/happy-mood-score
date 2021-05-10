# frozen_string_literal: true

module Votes
  class Weekly
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

    attr_reader :interval, :company, :results

    def header
      {
        title: I18n.t('hmsTrends.monthlyTrends'),
        link: Rails.application.routes.url_helpers.global_admin_trends_path,
        link_title: I18n.t('hmsTrends.showMonths')
      }
    end

    def content
      votes
      {
        title_feedback: I18n.t('hmsTrends.feedback6Weeks'),
        title_hms: I18n.t('hmsTrends.hms6Weeks'),
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
      start_week = interval
      while start_week > 0
        start_date = start_week.weeks.ago.beginning_of_week
        end_date = start_week.weeks.ago.end_of_week
        results << Graphs::Range.new(company, start_date, end_date).by_week
        start_week -= 1
      end
    end
  end
end
