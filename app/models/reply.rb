class Reply < ApplicationRecord
  belongs_to :vote
  belongs_to :employee

  validates :description, presence: true

  after_create :send_reply_email

  private

  def send_reply_email
    FeedbackMailer.reply_email(self).deliver_later
  end
end
