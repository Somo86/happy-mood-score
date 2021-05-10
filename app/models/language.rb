class Language < ApplicationRecord
  has_many :companies
  has_many :employees

  validates :name, presence: true
  validates :code, presence: true
end
