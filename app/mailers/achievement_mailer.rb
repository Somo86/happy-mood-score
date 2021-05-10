# frozen_string_literal: true

class AchievementMailer < ApplicationMailer
  def notify(achievement)
    user = achievement.employee.user
    @company = achievement.employee.company
    @employee = achievement.employee
    @achievement = achievement

    mail to: user.email, subject: I18n.t('server.achievementEmployeeEmail.subject', company_name: @company.name)
  end
end
