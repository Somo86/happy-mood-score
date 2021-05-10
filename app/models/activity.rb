class Activity < ApplicationRecord
  belongs_to :event
  belongs_to :employee
  belongs_to :sender, class_name: 'Employee', optional: true

  validates :sender_id, presence: true, if: -> { event&.high5? }
  validate :sender_and_receiver_are_different

  before_create :set_default_value
  after_create :increase_receiver_points
  after_create :check_for_new_rewards
  after_create :notify_high5

  scope :within_period, ->(starts_at, ends_at) { where(created_at: starts_at..ends_at) }
  scope :high5s, -> { joins(:event).where('events.category = 1') }

  private

  def check_for_new_rewards
    Achievements::Checker.new(self).new_rewards
  end

  def increase_receiver_points
    employee.update(points: employee.points + value)
  end

  def notify_high5
    return unless event.high5?

    ActivityMailer.new_high5(self).deliver_later
  end

  def sender_and_receiver_are_different
     errors.add(:base, I18n.t('high5New.yourself')) if sender_id == employee_id
  end

  def set_default_value
    return if value.positive?

    self.value = event.value
  end
end
