# frozen_string_literal: true

module Slack
  class Account
    class << self
      def authorise(params)
        new(params).authorise
      end
    end

    def initialize(params)
      @company = Company.find(params[:state])
      @params = {
        client_id: Rails.application.credentials.dig(:slack, :client_id),
        client_secret: Rails.application.credentials.dig(:slack, :client_secret),
        code: params[:code]
      }
    end

    def authorise
      token_info = request_access_token

      return false if token_info.blank? || token_info[:access_token].blank? || token_info[:team_id].blank?

      company.update(slack_token: token_info[:access_token], slack_team_id: token_info[:team_id])
    end

    private

    attr_reader :company, :params

    def request_access_token
      slack_oauth_endpoint = URI('https://slack.com/api/oauth.access')
      response = Net::HTTP.get(slack_oauth_endpoint, params)

      response.is_a?(Net::HTTPSuccess) ? JSON.parse(response.body).symbolize_keys : {}
    end
  end
end
