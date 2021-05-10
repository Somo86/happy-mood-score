# frozen_string_literal: true

module Rules
  class NewAccount
    class << self
      def setup!(company)
        feedback_rules(company)
        ideas_rules(company)
        levels_rules(company)
      end

      private

      def feedback_rules(company)
        event = company.events.find_by(name: 'Feedback')
        create_rules(feedback_info, event, company)
      end

      def ideas_rules(company)
        event = company.events.find_by(name: 'Idea')
        create_rules(ideas_info, event, company)
      end

      def levels_rules(company)
        create_rules(levels_info, nil, company)
      end

      def create_rules(rules_info, event, company)
        rules_info.each do |info|
          reward = company.rewards.find_by(name: info[:name])
          rule = reward.rules.create!(name: reward.name, reward_id: reward.id)
          info[:conditions].merge!(event_id: event.id) if event
          rule.conditions.create!(info[:conditions])
        end
      end

      def levels_info
        [
          {
            name: 'Level 1',
            conditions:
            {
              operation: 0,
              expression: 'gte',
              value: 50,
            },
          },
          {
            name: 'Level 2',
            conditions:
            {
              operation: 0,
              expression: 'gte',
              value: 100,
            },
          },
          {
            name: 'Level 3',
            conditions:
            {
              operation: 0,
              expression: 'gte',
              value: 200,
            },
          },
          {
            name: 'Level 4',
            conditions:
            {
              operation: 0,
              expression: 'gte',
              value: 400,
            },
          },
          {
            name: 'Level 5',
            conditions:
            {
              operation: 0,
              expression: 'gte',
              value: 800,
            },
          },
          {
            name: 'Level 6',
            conditions:
            {
              operation: 0,
              expression: 'gte',
              value: 1300,
            },
          },
          {
            name: 'Level 7',
            conditions:
            {
              operation: 0,
              expression: 'gte',
              value: 2000,
            },
          },
          {
            name: 'Level 8',
            conditions:
            {
              operation: 0,
              expression: 'gte',
              value: 2700,
            },
          },
          {
            name: 'Level 9',
            conditions:
            {
              operation: 0,
              expression: 'gte',
              value: 3500,
            },
          },
          {
            name: 'Level 10',
            conditions:
            {
              operation: 0,
              expression: 'gte',
              value: 5000,
            },
          },
        ]
      end

      def ideas_info
        [
          {
            name: 'Thomas Edison',
            conditions:
            {
              operation: 1,
              expression: 0,
              value: 1,
            },
          },
          {
            name: 'Leonardo Da Vinci',
            conditions:
            {
              operation: 1,
              expression: 0,
              value: 5,
            },
          },
          {
            name: 'Isaac Newton',
            conditions:
            {
              operation: 1,
              expression: 0,
              value: 15,
            },
          },
          {
            name: 'Albert Einstein',
            conditions:
            {
              operation: 1,
              expression: 0,
              value: 30,
            },
          },
          {
            name: 'Nikola Tesla',
            conditions:
            {
              operation: 1,
              expression: 0,
              value: 50,
            },
          },
        ]
      end

      def feedback_info
        [
          {
            name: 'Feedback aficionado',
            conditions:
            {
              operation: 1,
              expression: 0,
              value: 1,
            },
          },
          {
            name: 'Feedback specialist',
            conditions:
            {
              operation: 1,
              expression: 0,
              value: 10,
            },
          },
          {
            name: 'Feedback lover',
            conditions:
            {
              operation: 1,
              expression: 0,
              value: 25,
            },
          },
          {
            name: 'Feedback expert',
            conditions:
            {
              operation: 1,
              expression: 0,
              value: 50,
            },
          },
          {
            name: 'Feedback king',
            conditions:
            {
              operation: 1,
              expression: 0,
              value: 100,
            },
          },
        ]
      end
    end
  end
end
