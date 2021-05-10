class PollOption < ApplicationRecord
  belongs_to :poll

  validates :title, presence: true, uniqueness: { scope: :poll_id, case_sensitive: false }
  validates :value, presence: true, uniqueness: { scope: :poll_id, case_sensitive: false }
end
