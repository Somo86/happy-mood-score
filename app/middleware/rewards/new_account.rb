# frozen_string_literal: true

module Rewards
  class NewAccount
    class << self
      def setup!(company)
        levels_info.each { |reward| company.rewards.create!(reward) }
        feedback_info.each { |reward| company.rewards.create!(reward) }
        ideas_info.each { |reward| company.rewards.create!(reward) }
      end

      private

      def levels_info
        [
          {
            category: 1,
            name: "Level 0",
            description: "This is just the beginning",
            image_path: "level0-prize.png",
          },
          {
            category: 1,
            name: "Level 1",
            description: "Earn 50 or more points",
            image_path: "level1-prize.png",
          },
          {
            category: 1,
            name: "Level 2",
            description: "Earn 100 or more points",
            image_path: "level2-prize.png",
          },
          {
            category: 1,
            name: "Level 3",
            description: "Earn 200 or more points",
            image_path: "level3-prize.png",
          },
          {
            category: 1,
            name: "Level 4",
            description: "Earn 400 or more points",
            image_path: "level4-prize.png",
          },
          {
            category: 1,
            name: "Level 5",
            description: "Earn 800 or more points",
            image_path: "level5-prize.png",
          },
          {
            category: 1,
            name: "Level 6",
            description: "Earn 1300 or more points",
            image_path: "level6-prize.png",
          },
          {
            category: 1,
            name: "Level 7",
            description: "Earn 2000 or more points",
            image_path: "level6-prize.png",
          },
          {
            category: 1,
            name: "Level 8",
            description: "Earn 2700 or more points",
            image_path: "level6-prize.png",
          },
          {
            category: 1,
            name: "Level 9",
            description: "Earn 3500 or more points",
            image_path: "level6-prize.png",
          },
          {
            category: 1,
            name: "Level 10",
            description: "Earn 5000 or more points",
            image_path: "level10-prize.png",
          }
        ]
      end

      def feedback_info
        [
          {
            category: 0,
            name: "Feedback aficionado",
            description: "Helping the company. You sent your first feedback message",
            image_path: "feedback1-prize.png",
          },
          {
            category: 0,
            name: "Feedback specialist",
            description: "This company is a better place because of you. You sent 10 feedback messages",
            image_path: "feedback2-prize.png",
          },
          {
            category: 0,
            name: "Feedback lover",
            description: "We all appreciate your time and effort. You sent 25 feedback messages.",
            image_path: "feedback3-prize.png",
          },
          {
            category: 0,
            name: "Feedback expert",
            description: "This company must be proud of you. You sent 50 feedback messages.",
            image_path: "feedback4-prize.png",
          },
          {
            category: 0,
            name: "Feedback king",
            description: "Thank you for being such a good employee. You sent 100 feedback messages.",
            image_path: "feedback5-prize.png",
          }
        ]
      end

      def ideas_info
        [
          {
            category: 0,
            name: "Thomas Edison",
            description: "Creativity is flowing. You sent your first idea.",
            image_path: "idea1-prize.png",
          },
          {
            category: 0,
            name: "Leonardo Da Vinci",
            description: "Like Leonardo you are able of focusing on more than just 1 idea. You sent 5 ideas.",
            image_path: "idea2-prize.png",
          },
          {
            category: 0,
            name: "Isaac Newton",
            description: "Your creativity is not constrained by the Laws of Physics. You sent 15 ideas.",
            image_path: "idea3-prize.png",
          },
          {
            category: 0,
            name: "Albert Einstein",
            description: "Your ideas travler faster than the speed of light. You sent 30 ideas messages.",
            image_path: "idea4-prize.png",
          },
          {
            category: 0,
            name: "Nikola Tesla",
            description: "Your brain is at full charge and generating ideas. You sent 50 ideas messages.",
            image_path: "idea5-prize.png",
          }
        ]
      end
    end
  end
end
