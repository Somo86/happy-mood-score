# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Slack::Note do
  describe '.create' do
    let!(:company) { create(:company) }
    let(:manager) { create(:employee, :manager, company: company, slack_username: 'manager') }
    let!(:employee) { create(:employee, company: company, slack_username: 'etherius') }
    let!(:receiver) { create(:employee, company: company, slack_username: '@sdi') }
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

    subject { described_class.create(params) }

    context 'with valid params' do
      context 'when user is not a manager' do
        let(:text) { 'Management is easy @sdi @Etherius' }

        it { is_expected.to eql 'Your note for 1 on 1 has been saved.' }

        it { expect{ subject }.to change { Note.count }.by(1) }
      end

      context 'when user is a manager' do
        let(:user_name) { manager.slack_username }

        let(:text) { 'Management is easy @sdi @EtheriuS' }

        it { is_expected.to eql 'Your notes for 1 on 1 have been saved.' }

        it { expect{ subject }.to change { Note.count }.by(2) }
      end
    end
  end
end
