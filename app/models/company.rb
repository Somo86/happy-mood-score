class Company < ApplicationRecord
  belongs_to :language
  has_many :employees, dependent: :destroy
  has_many :teams, dependent: :destroy
  has_many :rewards, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :polls, dependent: :destroy
  has_many :historical_logs, dependent: :destroy
  has_many :users, through: :employees
  has_many :activities, through: :employees
  enum frequency: { daily: 0, weekly: 1, monthly: 2 }
  enum weekday: { monday: 0, tuesday: 1, wednesday: 2, thursday: 3, friday: 4 }

  validates :name, presence: true
  validates :email, presence: true
  validates :slug, uniqueness: { case_sensitive: false }

  before_create :add_slug
  before_create :default_settings
  before_update :update_job_delivery
  after_create :add_new_account
  after_create :add_empty_log

  scope :active, -> { where(deleted_at: nil) }
  scope :archived, -> { where.not(deleted_at: nil) }
  scope :with_request_enabled, -> { active.where.not(next_request_at: nil) }

  class << self
    def date_formats_for_select
      [
        [1, 'YYYY-MM-DD'],
        [2, 'DD-MM-YYYY'],
        [3, 'MM-DD-YYYY']
      ]
    end

    def frequencies_for_select
      [
        ['daily', I18n.t('companyEmailDelivery.daily')],
        ['weekly', I18n.t('companyEmailDelivery.weekly')],
        ['monthly', I18n.t('companyEmailDelivery.monthly')]
      ]
    end

    def weekdays_for_select
      [
        ['monday', I18n.t('companyEmailDelivery.monday')],
        ['tuesday', I18n.t('companyEmailDelivery.tuesday')],
        ['wednesday', I18n.t('companyEmailDelivery.wednesday')],
        ['thursday', I18n.t('companyEmailDelivery.thursday')],
        ['friday', I18n.t('companyEmailDelivery.friday')]
      ]
    end

    def hours_for_select
      (8..21).flat_map do |hour|
        [
          [("%02d:00" % hour), ("%02d:00" % hour)],
          [("%02d:30" % hour), ("%02d:30" % hour)]
        ]
      end
    end
  end

  def admin
    employees.find_by(role: :admin)
  end

  def last_log
    historical_logs.order(generated_on: :desc).first
  end

  def remove
    update!(name: "#{name}_deleted", slug: "#{slug}_deleted", deleted_at: Time.current)
  end

  def slack_enabled?
    slack_token.present? && slack_team_id.present?
  end

  private

  def add_empty_log
    historical_logs.create!
  end

  def add_new_account
    Companies::NewAccount.setup!(self)
  end

  def add_slug
    self.slug = name.parameterize
  end

  def default_settings
    self.timezone = 'London'
    self.frequency = :weekly
    self.weekday = 'friday'
  end

  def update_job_delivery
    return unless delivery_active_and_values_changed?

    self.next_request_at = Jobs::Dates.new(self).next_request
  end

  def delivery_active_and_values_changed?
    next_request_at.present? && (frequency_changed? || weekday_changed? || hour_changed?)
  end
end
