# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Slack::Vote do
  describe '#create' do
    let(:vote) { create(:vote) }
    let(:callback_id) { vote.token }
    let(:token) { 'AMORPHIS' }
    let(:action) { 'fine' }
    let(:team_id) { vote.company.slack_team_id }
    let(:params) do
      {
        callback_id: callback_id,
        token: token,
        action: action,
        team: { id: team_id }
      }
    end

    subject { described_class.new(params).create }

    context 'when data is valid' do
      it { is_expected.to eql 'Your status update has been received. Thank you! You can now send a feedback message explaining your status. Type /report and write your message.' }
    end

    context 'when token is invalid' do
      let(:token) { 'invalid' }

      it { is_expected.to eql 'You have already send your vote for this request.' }
    end

    context 'when callback_id is invalid' do
      let(:callback_id) { 'invalid' }

      it { is_expected.to eql 'You have already send your vote for this request.' }
    end

    context 'when team_id is invalid' do
      let(:team_id) { 'invalid' }

      it { is_expected.to eql 'You have already send your vote for this request.' }
    end

    context 'when action is invalid' do
      let(:action) { 'invalid' }

      it { is_expected.to eql 'Invalid update.' }
    end
  end
end
