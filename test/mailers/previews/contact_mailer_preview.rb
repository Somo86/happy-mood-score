# frozen_string_literal: true

class ContactMailerPreview < ActionMailer::Preview
  def send_email
    ContactMailer.send_email(User.first, 'Some message')
  end
end
