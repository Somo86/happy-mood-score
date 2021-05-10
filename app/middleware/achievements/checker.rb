# frozen_string_literal: true

module Achievements
  class Checker
    attr_reader :activity

    def initialize(activity)
      @activity = activity
    end

    def new_rewards
      rewards.each do |reward|
        employee.achievements.create( reward: reward)
      end
    end

    private

    def rewards
      @rewards ||= Rewards::Checker.acquired(activity)
    end

    def employee
      activity.employee
    end
  end
end
