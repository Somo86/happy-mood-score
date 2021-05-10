class HistoricalLog < ApplicationRecord
  belongs_to :employee, optional: true
  belongs_to :team, optional: true
  belongs_to :company, optional: true
end
