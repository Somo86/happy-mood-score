class Poll < ApplicationRecord
  belongs_to :company

  has_many :poll_options, dependent: :destroy
  has_many :poll_votes, dependent: :destroy

  accepts_nested_attributes_for :poll_options

  validates :name, presence: true, uniqueness: { scope: :company_id, case_sensitive: false }
  validates :title, presence: true, on: :update

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  before_create :add_slug
  before_destroy :check_inactive
  after_create :add_default_options

  private

  def add_default_options
    Polls::Options.default(self)
  end

  def add_slug
    self.slug = name.parameterize
  end

  def check_inactive
    throw :abort if active
  end
end
