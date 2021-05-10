# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Slack::Account do
  describe '.authorise' do
    let(:company) { create(:company) }
    let(:params) {  { state: company.id, code: 'random-code' } }
    let(:slack_body) { { access_token: 'access-token', team_id: 'team-id' }.to_json }
    let(:response) { Net::HTTPSuccess.new(1.0, '200', 'OK') }

    before do
      allow(Net::HTTP).to receive(:get).and_return(response)
      allow(response).to receive(:body).and_return(slack_body)
    end

    subject { described_class.new(params).authorise }

    context 'when request is valid' do
      it { is_expected.to be true }

      context 'company access' do
        before { described_class.new(params).authorise }

        subject { company.reload }

        its(:slack_token) { is_expected.to eql 'access-token' }
        its(:slack_team_id) { is_expected.to eql 'team-id' }
      end
    end

    context 'when request is invalid' do
      let(:response) { Net::HTTPUnauthorized.new(1.0, '401', 'OK') }
      let(:slack_body) { {} }

      it { is_expected.to be false }
    end
  end
end
