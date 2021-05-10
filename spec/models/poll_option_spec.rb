# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PollOption, type: :model do
  subject { build(:poll_option) }

  it { is_expected.to belong_to :poll }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:value) }
  it { is_expected.to validate_uniqueness_of(:title).scoped_to(:poll_id).case_insensitive }
  it { is_expected.to validate_uniqueness_of(:value).scoped_to(:poll_id).case_insensitive }
end
