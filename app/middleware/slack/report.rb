# frozen_string_literal: true

module Slack
  class Report
    include Verified

    class << self
      def create(params)
        new(params).create
      end
    end

    def initialize(params)
      @token = params[:token]
      @team_id = params[:team_id]
      @user_name = params[:user_name]
      @text = params[:text]
    end

    def create
      return I18n.t('server.slackFeedback.noResult') unless valid_report?

      if vote.update(description: text)
        I18n.t('server.slackFeedback.feedbackSaved')
      else
        I18n.t('server.slackFeedback.noResult')
      end
    end

    private

    attr_reader :team_id, :token, :user_name, :text

    def add_vote
      vote = employee.votes.create
      vote.update(result: vote_result)

      vote
    end

    def employee
      @employee ||= company.employees.active.with_username(user_name).first
    end

    def valid_report?
      valid_request? && employee.present? && vote.present?
    end

    def vote
      @vote ||= (employee.votes.last_without_comment || add_vote)
    end

    def vote_result
      if text.include? ':thumbsdown:'
        return 10
      elsif text.include? ':thumbsup:'
        return 30
      end

      20
    end
  end
end
