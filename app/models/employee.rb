class Employee < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :company
  belongs_to :language
  belongs_to :team

  has_many :achievements, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :historical_logs, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy do |attachment|
    attachment.variant :thumb, resize: "250x250"
  end

  enum role: { employee: 0, manager: 1, admin: 2, god: 99 }

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :slack_username, uniqueness: { scope: :company_id, case_sensitive: false, allow_nil: true, allow_blank: true }

  before_create :add_user
  after_create :add_empty_log
  after_create :increase_team_counter
  after_update :decrease_team_counter

  scope :active, -> { where(deleted_at: nil) }
  scope :archived, -> { where.not(deleted_at: nil) }
  scope :with_username, -> (user_name) { where('slack_username = ? OR slack_username = ?', user_name, "@#{user_name}") }

  def administration?
    admin? || god?
  end

  def deleted?
    deleted_at.present?
  end

  def high5s
  end

  def last_log
    historical_logs.order(generated_on: :desc).first
  end

  def management?
    manager? || admin? || god?
  end

  def reward_ids
    achievements.pluck(:reward_id)
  end

  def slack_enabled?
    company.slack_enabled? && slack_username.present?
  end

  private

  def add_empty_log
    historical_logs.create!
  end

  def add_user
    password = SecureRandom.alphanumeric(26)

    self.api_key = SecureRandom.hex(10)
    self.user = User.create!(email: email, password: password, password_confirmation: password)
  end

  def decrease_team_counter
    Counters::Team.remove_employee(team.id) if employee_is_archived?
  end

  def employee_is_archived?
    deleted_at.present? && deleted_at_changed?
  end

  def increase_team_counter
    Counters::Team.add_employee(team.id)
  end
end
