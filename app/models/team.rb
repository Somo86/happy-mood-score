class Team < ApplicationRecord
  belongs_to :company
  has_many :employees, -> { where deleted_at: nil }
  has_many :votes, dependent: :nullify
  has_many :historical_logs, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :company_id, case_sensitive: false }

  after_create :add_empty_log

  scope :with_employees, -> { where('employees_count > 0') }

  def last_log
    historical_logs.order(generated_on: :desc).first
  end

  private

  def add_empty_log
    historical_logs.create!
  end
end
