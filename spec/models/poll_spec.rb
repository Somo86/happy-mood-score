# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Poll, type: :model do
  subject { build(:poll) }

  it { is_expected.to belong_to :company }
  it { is_expected.to have_many :poll_options }
  it { is_expected.to have_many :poll_votes }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:company_id).case_insensitive }

  describe 'after create' do
    let(:name) { 'What a weird ñamé' }

    subject { create(:poll, name: name) }

    its(:slug) { is_expected.to eql name.parameterize }

    context 'default options' do
      it { expect { subject }.to change { PollOption.count }.by(3) }
    end
  end
end
