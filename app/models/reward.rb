class Reward < ApplicationRecord
  belongs_to :company
  has_many :rules, dependent: :destroy
  has_many :achievements, dependent: :destroy

  enum category: { badge: 0, level: 1 }

  validates :category, presence: true
  validates :name, presence: true, uniqueness: { scope: :company_id, case_sensitive: false }

  scope :active, -> { where(active: true) }
  scope :badges, -> { where(category: 0) }
  scope :levels, -> { where(category: 1) }

  class << self
    def excluding_ids(ids)
      return self if ids.empty?

      where('id NOT IN (?)', ids)
    end
  end
end
