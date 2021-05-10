# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API Company' do
  let(:employee) { create(:employee, :manager) }
  let(:token) { employee.api_key }
  let(:company) { employee.company }
  let!(:teams) { create_list(:team, 3, company: company) }
  let(:name) {}
  let(:headers) { { 'ACCEPT' => 'application/json', 'Authorization' => "Bearer #{token}" } }

  describe '#index' do
    subject do
      get '/api/v3/teams', headers: headers
      response
    end

    it_behaves_like 'invalid token'

    it_behaves_like 'employee not manager'

    context 'when user is manager' do
      it { is_expected.to have_http_status :success }

      it { subject; expect(JSON.parse(response.body)).to include(a_hash_including({ "id" => teams[1].uuid })) }
    end
  end

  describe '#show' do
    let(:team_info) { JSON.parse(response.body) }

    subject do
      get "/api/v3/teams/#{teams[2].uuid}", headers: headers
      response
    end

    it_behaves_like 'invalid token'

    it_behaves_like 'employee not manager'

    context 'when user is manager' do
      it { is_expected.to have_http_status :success }

      it { subject; expect(team_info).to include({ "id" => teams[2].uuid }) }
      it { subject; expect(team_info).to include({ "name" => teams[2].name }) }
    end
  end

  describe '#create' do
    let(:params) { { name: name } }

    subject do
      post '/api/v3/teams', params: params, headers: headers
      response
    end

    it_behaves_like 'invalid token'

    it_behaves_like 'employee not manager'

    context 'when data is valid' do
      let(:name) { 'New team' }
      let(:new_team) { company.teams.last }
      let(:team_info) { JSON.parse(response.body) }

      context 'new team info' do
        before { subject }

        it { is_expected.to have_http_status :success }
        it { expect(team_info).to include({ "id" => new_team.uuid }) }
        it { expect(team_info).to include({ "name" => new_team.name }) }
        it { expect(team_info).to include({ "totalEmployees" => new_team.employees_count }) }

        context 'when data is invalid' do
          let(:name) {}

          it { is_expected.to have_http_status :success }
          it { expect(team_info).to include({ "name" => ["can't be blank"] }) }
        end
      end
    end
  end

  describe '#update' do
    let(:team) { teams[0] }
    let(:params) { { name: name } }

    subject do
      put "/api/v3/teams/#{team.uuid}", params: params, headers: headers
      response
    end

    it_behaves_like 'invalid token'

    it_behaves_like 'employee not manager'

    context 'when data is valid' do
      let(:name) { 'Updated team' }
      let(:team_info) { JSON.parse(response.body) }

      context 'new team info' do
        before { subject }

        it { is_expected.to have_http_status :success }
        it { expect(team_info).to include({ "id" => team.reload.uuid }) }
        it { expect(team_info).to include({ "name" => team.reload.name }) }
        it { expect(team_info).to include({ "totalEmployees" => team.reload.employees_count }) }

        context 'when data is invalid' do
          let(:name) {}

          it { is_expected.to have_http_status :success }
          it { expect(team_info).to include({ "name" => ["can't be blank"] }) }
        end
      end
    end
  end
end
