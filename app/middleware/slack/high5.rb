# frozen_string_literal: true

module Slack
  class High5
    include Verified
    include Received

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
      return text if text.start_with?('#usernames#')

      return I18n.t('server.slackFeedback.noResult') unless valid_content?

      high5s = create_high5s

      return I18n.t('server.slackHigh5.zero') if high5s.zero?
      return I18n.t('server.slackHigh5.one') if high5s == 1
      return I18n.t('server.slackHigh5.many') if high5s > 1
    end

    private

    attr_reader :team_id, :token, :user_name, :text

    def create_high5s
      total = 0
      receivers.each do |slack_user_name|
        receiver = find_receiver(slack_user_name)

        if receiver
          Activities::High5.create(employee, receiver, text)
          total += 1
        end
      end

      total
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
