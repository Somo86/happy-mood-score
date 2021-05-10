# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Slack::High5 do
  describe '#create' do
    let!(:company) { create(:company) }
    let(:employee) { create(:employee, company: company, slack_username: 'Etherius') }
    let(:team_id) { company.slack_team_id }
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

    context 'with valid params' do
      context 'when text starts with usernames' do
        let(:text) { '#usernames# user_name other_username another' }

        it { is_expected.to eql text }
      end

      context 'when just one receiver found' do
        let!(:receiver) { create(:employee, company: company, slack_username: '@sdi') }
        let(:text) { 'This reward goes to @sdi' }

        it { is_expected.to eql 'Your High 5 has been saved.' }

        it { expect{ subject }.to change { Activity.count }.by(1) }
      end

      context 'when many receivers found' do
        let!(:receiver) { create(:employee, company: company, slack_username: '@sdi') }
        let!(:receiver2) { create(:employee, company: company, slack_username: 'tribulation') }
        let(:text) { 'This reward goes to @sdi @fake_user and @tribulation' }

        it { is_expected.to eql 'Your High 5s have been saved.' }

        it { expect{ subject }.to change { Activity.count }.by(2) }
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
