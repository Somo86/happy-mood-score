# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HistoricalLog, type: :model do
  it { is_expected.to belong_to(:company).optional }
  it { is_expected.to belong_to(:team).optional }
  it { is_expected.to belong_to(:employee).optional }
end
