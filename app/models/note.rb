class Note < ApplicationRecord
  belongs_to :employee
  belongs_to :receiver, class_name: "Employee", foreign_key: :receiver_id, optional: true

  validates :description, presence: true
  before_create :add_receiver

  scope :active, -> { where(done: false) }
  scope :closed, -> { where(done: true) }
  scope :shared, -> { where(shared: true) }

  private

  def add_receiver
    self.receiver_id = employee_id if receiver_id.blank?
  end
end
