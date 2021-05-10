# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Language, type: :model do
  it { is_expected.to have_many :companies }
  it { is_expected.to have_many :employees }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:code) }
end
