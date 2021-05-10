# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API Company' do
  describe '#index' do
    let(:token) { employee.api_key }

    subject do
      get '/api/v3/company', headers: { 'ACCEPT' => 'application/json', 'Authorization' => "Bearer #{token}" }
      response
    end

    it_behaves_like 'invalid token'

    it_behaves_like 'employee not manager'

    context 'when user is manager' do
      let(:employee) { create(:employee, :manager) }

      it { is_expected.to have_http_status :success }

      it { subject; expect(JSON.parse(response.body)).to include({ "id" => employee.company.uuid }) }
    end
  end
end
