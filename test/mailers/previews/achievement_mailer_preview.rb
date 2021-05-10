# frozen_string_literal: true

class AchievementMailerPreview < ActionMailer::Preview
  def notify
    achievement = Achievement.create!(reward: Reward.first, employee: Employee.first)

    AchievementMailer.notify(achievement)
  end
end
