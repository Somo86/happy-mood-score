class Vote < ApplicationRecord
  belongs_to :company
  belongs_to :team
  belongs_to :employee

  has_many :replies, dependent: :destroy

  validates :result, inclusion: { in: [10, 20, 30] }, allow_nil: true
  validates :result, presence: true, on: :update

  before_validation :add_token_and_denormalise, on: :create
  before_update :remove_token
  after_save :update_feedback_activity, if: -> { saved_change_to_description? }
  after_save :update_result_activity, if: -> { saved_change_to_result? }

  scope :votable, -> { where.not(token: nil) }
  scope :voted, -> { where(token: nil) }
  scope :recent, -> { where(recent: true) }
  scope :good, -> { voted.where(result: 30) }
  scope :fine, -> { voted.where(result: 20) }
  scope :bad, -> { voted.where(result: 10) }
  scope :with_comments, -> { voted.where.not(description: nil) }

  class << self
    def last_without_comment
      where(token: nil).where(description: nil).order(generated_at: :desc).first
    end
  end

  private

  def add_token_and_denormalise
    self.company = employee.company
    self.team = employee.team
    self.token = SecureRandom.hex(19)
  end

  def remove_token
    self.token = nil
  end

  def update_feedback_activity
    Activities::Vote.new_feedback(self)
  end

  def update_result_activity
    Activities::Vote.new_result(self)
  end
end
