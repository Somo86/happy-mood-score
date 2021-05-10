# frozen_string_literal: true

module Events
  class NewAccount
    class << self
      def setup!(company)
        event_info.each { |event| company.events.create!(event) }
      end

      private

      def event_info
        [
          {
            category: 1,
            name: 'Hi5',
            description: 'High 5 is a recognition between peers.',
            value: 5,
            image_path: 'hi5-reward.png',
            activity_description: 'has received a High 5'
          },
          {
            category: 2,
            name: 'Feedback',
            description: 'Give feedback',
            value: 10,
            image_path: 'feedback-vote-reward.png',
            activity_description: 'added feedback'
          },
          {
            category: 3,
            name: 'Vote',
            description: 'sent a mood status update.',
            value: 1,
            image_path: 'vote-reward.png',
            activity_description: 'has updated status'
          },
          {
            category: 4,
            name: 'Idea',
            description: 'Add a new idea',
            value: 10,
            image_path: 'idea-reward.png',
            activity_description: 'has added a new idea.'
          },
          {
            category: 5,
            name: 'IdeaVote',
            description: 'Like an idea',
            value: 1,
            image_path: 'idea-vote-reward.png',
            activity_description: 'has liked an idea.'
          },
          {
            category: 6,
            name: 'IdeaComment',
            description: 'Add a comment to an idea',
            value: 3,
            image_path: 'idea-vote-reward.png',
            activity_description: 'has added a comment to an idea.'
          }
        ]
      end
    end
  end
end
