# frozen_string_literal: true

class FeedbackMailer < ApplicationMailer
  def request_email(employee, token)
    company = employee.company
    period_name = I18n.t("server.newUserOnboarding.#{company.frequency}")
    @message_data = {
      user_name: employee.name,
      period_name: period_name,
      company_name: company.name,
      admin_name: company.admin.name,
      admin_email: company.admin.email,
      vote_id: token
    }
    mail(to: employee.email, subject: I18n.t('server.sendEmailToEmployee.subject', company_name: company.name, period_name: period_name))
  end

  def reply_email(reply)
    @reply = reply
    email = reply.vote.employee.email
    company_name = reply.vote.company.name
    mail(to: email, subject: I18n.t('server.feedbackReplyEmail.subject', company_name: company_name))
  end
end
