# frozen_string_literal: true

module Polls
  class Options
    class << self
      def default(poll)
        poll.poll_options.create(
          [
            positive_option,
            neutral_option,
            negative_option
          ]
        )
      end

      private

      def positive_option
        {
          title: I18n.t('server.feedbackApi.betterThanExpected'),
          value: 30
        }
      end

      def neutral_option
        {
          title: I18n.t('server.feedbackApi.asExpected'),
          value: 20
        }
      end

      def negative_option
        {
          title: I18n.t('server.feedbackApi.worseThanExpected'),
          value: 10
        }
      end
    end
  end
end
