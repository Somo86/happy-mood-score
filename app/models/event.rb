class Event < ApplicationRecord
  belongs_to :company
  has_many :activities, dependent: :destroy

  enum category: { generic: 0, high5: 1, feedback: 2, vote: 3, idea: 4, idea_vote: 5, idea_comment: 6 }

  validates :name, presence: true, uniqueness: { scope: :company_id, case_sensitive: false }
  validates :value, presence: true, numericality: { only_integer: true }
end
