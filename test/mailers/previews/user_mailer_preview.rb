# frozen_string_literal: true

class UserMailerPreview < ActionMailer::Preview
  def activation_needed_email
    UserMailer.with(user: User.first).activation_needed_email
  end

  def activation_success_email
    UserMailer.with(user: User.first).activation_success_email
  end

  def reset_password_email
    UserMailer.with(user: User.first).reset_password_email
  end
end
