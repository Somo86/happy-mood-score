# frozen_string_literal: true

module Rewards
  class Checker
    attr_reader :reward, :activity

    class << self
      def acquired(activity)
        Reward.active.excluding_ids(activity.employee.reward_ids).all.map { |reward| new(reward, activity).achieved }.compact
      end
    end

    def initialize(reward, activity)
      @reward = reward
      @activity = activity
    end

    def achieved
      valid = rules.any? { |rule| Rules::Checker.new(rule, employee).apply? }

      valid ? reward : nil
    end

    private

    def employee
      activity.employee
    end

    def rules
      reward.rules.within_period(activity.created_at)
    end
  end
end
