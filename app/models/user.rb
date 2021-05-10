class User < ApplicationRecord
  authenticates_with_sorcery!

  has_one :employee, dependent: :destroy

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  before_update :setup_activation, if: -> { email_changed? }
  after_update :send_activation_needed_email!, if: -> { previous_changes['email'].present? }

  delegate :language, to: :employee
  delegate :company, to: :employee
  delegate :name, to: :employee
  delegate :admin?, to: :employee
end
