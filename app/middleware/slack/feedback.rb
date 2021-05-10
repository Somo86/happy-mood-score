# frozen_string_literal: true

module Slack
  class Feedback
    class << self
      def request(vote)
        new(vote).request
      end
    end

    def initialize(vote)
      @vote = vote
      I18n.locale = employee.language.code
    end

    def request
      response = make_request
      Rails.logger.info response.message

      response.is_a? Net::HTTPSuccess
    end

    private

    attr_reader :vote

    def make_request
      uri = URI('https://slack.com/api/chat.postMessage')
      req = Net::HTTP::Post.new(uri.request_uri)
      req.set_form_data params
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      http.request(req)
    end

    def params
      {
        token: company.slack_token,
        channel: employee.slack_username,
        as_user: false,
        text: message_title,
        attachments: message_body
      }
    end

    def company
      vote.company
    end

    def employee
      vote.employee
    end

    def message_title
      "#{I18n.t('hello')} #{employee.name}:\n #{question}?\n\n"
    end

    def message_body
      [
        {
          text: I18n.t('server.feedbackApi.selectOneOption'),
          fallback: 'Feedback has not been reported.',
          callback_id: vote.token,
          color: '#3AA3E3',
          attachment_type: 'default',
          actions: [
            {
              name: 'fine',
              text: I18n.t('server.feedbackApi.asExpected'),
              type: 'button',
              value: 'fine'
            },
            {
              name: 'good',
              text: I18n.t('server.feedbackApi.betterThanExpected'),
              style: 'primary',
              type: 'button',
              value: 'good'
            },
            {
              name: 'bad',
              text: I18n.t('server.feedbackApi.worseThanExpected'),
              style: 'danger',
              type: 'button',
              value: 'bad'
            }
          ]
        }
      ]
    end

    def question
      I18n.t('sendSlackToEmployee.subject', period_name: period_name)
    end

    def period_name
      I18n.t("server.newUserOnboarding.#{company.frequency}")
    end
  end
end
