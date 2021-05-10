# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PollVote, type: :model do
  it { is_expected.to belong_to(:poll).counter_cache }

  it { is_expected.to validate_presence_of :result }

  describe 'add option title' do
    let(:result) { 'super' }
    let(:poll) { create(:poll) }
    let(:poll_option) { create(:poll_option, title: 'Soilwork', value: result, poll: poll) }

    subject { create(:poll_vote, poll: poll, result: poll_option.value) }

    its(:option_title) { is_expected.to eql poll_option.title }
    its(:result) { is_expected.to eql result }
  end
end
