# frozen_string_literal: true

class ContactMailer < ApplicationMailer
  def send_email(user, user_message)
    @user = user
    @user_message = user_message
    mail(to: user.email, subject: "Contact company: #{user.employee.name}")
  end
end
