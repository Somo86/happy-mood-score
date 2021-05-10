class Achievement < ApplicationRecord
  belongs_to :reward
  belongs_to :employee

  after_create :notify_achievement
  after_create :update_employee_level

  private

  def notify_achievement
    AchievementMailer.notify(self).deliver_later
  end

  def update_employee_level
    employee.update(level_name: reward.name) if reward.level?
  end
end
