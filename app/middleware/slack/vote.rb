# frozen_string_literal: true

module Slack
  class Vote
    include Verified

    class << self
      def create(params)
        new(params).create
      end
    end

    def initialize(params)
      @callback_id = params[:callback_id]
      @token = params[:token]
      @action = params[:action]
      @team_id = params[:team][:id]
    end

    def create
      return I18n.t('server.slackFeedback.wrongVote') unless valid_vote?

      if vote.update(result: action_to_number)
        I18n.t('server.slackFeedback.received')
      else
        I18n.t('server.slackFeedback.noResult')
      end
    end

    private

    attr_reader :callback_id, :token, :action, :team_id

    def action_to_number
      case action
      when 'good'
        30
      when 'fine'
        20
      when 'bad'
        10
      else
        0
      end
    end

    def valid_vote?
      vote.present? && valid_request?
    end

    def vote
      @vote ||= ::Vote.find_by(token: callback_id)
    end
  end
end
