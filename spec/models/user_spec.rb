# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it { is_expected.to have_one :employee }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_presence_of(:password).on(:create).with_message("is too short (minimum is 8 characters)") }
  it { is_expected.to validate_length_of(:password).on(:create).is_at_least(8) }
  it { is_expected.to validate_presence_of(:password_confirmation).on(:create) }

end
