# frozen_string_literal: true

class FeedbackMailerPreview < ActionMailer::Preview
  def request_email
    FeedbackMailer.request_email(User.first, 'test-vote')
  end

  def reply_email
    FeedbackMailer.reply_email(Reply.first)
  end
end
