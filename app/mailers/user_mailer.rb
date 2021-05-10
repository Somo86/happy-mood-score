# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def activation_needed_email(user)
    @user = user
    @url = activate_user_url(@user.activation_token)
    @company_name = @user.company.name
    @admin = @user.company.admin.user
    mail(to: user.email, subject: I18n.t('server.accountActivateEmail.subject'))
  end

  def activation_success_email(user)
    @user = user
    @url  = login_url
    mail(to: user.email, subject: I18n.t('server.accountActivatedEmail.subject'))
  end

  def reset_password_email(user)
    @user = User.find(user.id)
    I18n.locale = @user.language.code
    @url = edit_password_reset_url(@user.reset_password_token)
    @subject = "[Happy Mood Score] #{I18n.t('resetPassword.subject')}"
    mail(to: user.email, subject: @subject)
  end
end
