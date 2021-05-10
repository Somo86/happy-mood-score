# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Slack', type: :request do
  let(:company) { create(:company) }
  let(:employee) { create(:employee, company: company, slack_username: 'star_systems') }
  let(:token) { 'AMORPHIS' }
  let(:team_id) { company.slack_team_id }

  describe '#auth' do
    subject do
      get auth_api_slack_url, params: { state: 1 }
      response
    end

    context 'when request is valid' do
      before { allow(Slack::Account).to receive(:authorise).and_return(true) }

      it { is_expected.to redirect_to admin_company_slack_url(1) }
    end

    context 'when request is invalid' do
      before { expect(Slack::Account).to receive(:authorise).and_return(false) }

      it { is_expected.to have_http_status :unauthorized }
    end
  end

  describe '#feedback' do
    let(:vote) { create(:vote, company: company) }
    let(:callback_id) { vote.token }
    let(:action) { 'fine' }
    let(:params) do
      {
        callback_id: callback_id,
        token: token,
        action: action,
        team: { id: team_id }
      }
    end

    subject do
      post feedback_api_slack_url, params: params
      response
    end

    its(:body) { is_expected.to eql 'Your status update has been received. Thank you! You can now send a feedback message explaining your status. Type /report and write your message.' }
  end

  describe '#high5' do
    let!(:receiver) { create(:employee, company: company, slack_username: '@venom') }
    let(:user_name) { employee.slack_username }
    let(:text) { 'A high 5 to @venom' }
    let(:params) do
      {
        team_id: team_id,
        token: token,
        user_name: user_name,
        text: text
      }
    end

    subject do
      post high5_api_slack_url, params: params
      response
    end

    its(:body) { is_expected.to eql 'Your High 5 has been saved.' }
  end

  describe '#one2one' do
    let!(:receiver) { create(:employee, company: company, slack_username: '@venom') }
    let(:user_name) { employee.slack_username }
    let(:text) { 'A high 5 to @venom' }
    let(:params) do
      {
        team_id: team_id,
        token: token,
        user_name: user_name,
        text: text
      }
    end

    subject do
      post '/api/slack/1on1', params: params
      response
    end

    its(:body) { is_expected.to eql 'Your note for 1 on 1 has been saved.' }
  end

  describe '#report' do
    let(:user_name) { employee.slack_username }
    let(:text) { 'Liquid Tension Experiment' }
    let(:params) do
      {
        team_id: team_id,
        token: token,
        user_name: user_name,
        text: text
      }
    end

    subject do
      post report_api_slack_url, params: params
      response
    end

    its(:body) { is_expected.to eql 'Your feedback has been saved. Thank you very much for your contribution.' }
  end
end

