# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Slack::Report do
  describe '#create' do
    let(:employee) { create(:employee, slack_username: 'Etherius') }
    let(:team_id) { employee.company.slack_team_id }
    let(:token) { 'AMORPHIS' }
    let(:user_name) { employee.slack_username }
    let(:text) { 'Sabbat - History of a time to come' }
    let(:params) do
      {
        team_id: team_id,
        token: token,
        user_name: user_name,
        text: text
      }
    end

    subject { described_class.new(params).create }

    context 'when data is valid' do
      context 'when vote exists' do
        let!(:vote) { create(:vote, :voted, employee: employee) }

        it { is_expected.to eql 'Your feedback has been saved. Thank you very much for your contribution.' }

        it { subject; expect(vote.reload.description).to eql text }
      end

      context 'when vote does not exist' do
        let(:vote) { employee.reload.votes.last }

        it { is_expected.to eql 'Your feedback has been saved. Thank you very much for your contribution.' }

        context 'when text does not include a thumbs icon' do
          it { subject; expect(vote.reload.description).to eql text }
          it { subject; expect(vote.reload.result).to eql 20 }
        end

        context 'when text includes a thumbsup icon' do
          let(:text) { 'Wonderful week :thumbsup:' }

          it { subject; expect(vote.reload.description).to eql text }
          it { subject; expect(vote.reload.result).to eql 30 }
        end

        context 'when text includes a thumbsdown icon' do
          let(:text) { 'Wonderful week :thumbsdown:' }

          it { subject; expect(vote.reload.description).to eql text }
          it { subject; expect(vote.reload.result).to eql 10 }
        end
      end
    end

    context 'when token is invalid' do
      let(:token) { 'invalid' }

      it { is_expected.to eql 'Invalid update.' }
    end

    context 'when callback_id is invalid' do
      let(:user_name) { 'user_name' }

      it { is_expected.to eql 'Invalid update.' }
    end

    context 'when team_id is invalid' do
      let(:team_id) { 'invalid' }

      it { is_expected.to eql 'Invalid update.' }
    end

    context 'when user_name is invalid' do
      let(:user_name) { 'invalid' }

      it { is_expected.to eql 'Invalid update.' }
    end
  end
end
