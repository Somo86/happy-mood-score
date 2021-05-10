# frozen_string_literal: true

module Slack
  class Note
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

      return I18n.t('server.slackTodo.noResult') unless valid_content?

      notes = create_notes

      return I18n.t('server.slackTodo.zero') if notes.zero?
      return I18n.t('server.slackTodo.one') if notes == 1
      return I18n.t('server.slackTodo.many') if notes > 1
    end

    private

    attr_reader :team_id, :token, :user_name, :text

    def create_notes
      total = 0

      if receivers.size.positive? && employee.manager?
        total = create_notes_with_receivers
      else
        employee.notes.create( description: text, shared: note_shared?)
        total = 1
      end

      total
    end

    def create_notes_with_receivers
      total = 0
      receivers.each do |slack_user_name|
        receiver = find_receiver(slack_user_name)

        if receiver
          employee.notes.create(
            description: text,
            receiver: receiver,
            shared: note_shared?
          )
          total += 1
        end
      end

      total
    end

    def note_shared?
      text.include? ':eyes:'
    end
  end
end
