# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API Company' do
  let(:employee) { create(:employee, :manager) }
  let(:token) { employee.api_key }
  let(:company) { employee.company }
  let(:team) { create(:team, company: company) }
  let!(:employees) { create_list(:employee, 3, company: company) }
  let(:name) {}
  let(:headers) { { 'ACCEPT' => 'application/json', 'Authorization' => "Bearer #{token}" } }

  describe '#index' do
    subject do
      get '/api/v3/employees', headers: headers
      response
    end

    it_behaves_like 'invalid token'

    context 'when employee is a manager' do
      it { is_expected.to have_http_status :success }

      it { subject; expect(JSON.parse(response.body)).to include(a_hash_including({ "id" => employees[1].uuid })) }
      it { subject; expect(JSON.parse(response.body)).to include(a_hash_including({ "hms" => employees[1].hms })) }
    end

    context 'when employee is not a manager' do
      let(:token) { employees[1].api_key }

      it { is_expected.to have_http_status :success }

      it { subject; expect(JSON.parse(response.body)).to include(a_hash_including({ "id" => employees[1].uuid })) }
      it { subject; expect(JSON.parse(response.body)).to_not include(a_hash_including({ "hms" => employees[1].hms })) }
    end
  end

  describe '#show' do
    let(:employee_info) { JSON.parse(response.body) }

    subject do
      get "/api/v3/employees/#{employees[0].uuid}", headers: headers
      response
    end

    it_behaves_like 'invalid token'

    context 'when employee is a manager' do
      it { is_expected.to have_http_status :success }

      it { subject; expect(employee_info).to include({ "id" => employees[0].uuid }) }
      it { subject; expect(employee_info).to include({ "hms" => employees[0].hms }) }
    end

    context 'when employee is not a manager' do
      let(:token) { employees[1].api_key }

      it { is_expected.to have_http_status :success }

      it { subject; expect(employee_info).to include({ "id" => employees[0].uuid }) }
      it { subject; expect(employee_info).to_not include({ "hms" => employees[0].hms }) }
    end
  end

  describe '#create' do
    let(:name) { 'New employee' }
    let(:email) { 'new@employee.com' }
    let(:team_id) { team.uuid }
    let(:params) { { name: name, email: email, team_id: team_id } }

    subject do
      post '/api/v3/employees', params: params, headers: headers
      response
    end

    it_behaves_like 'invalid token'

    it_behaves_like 'employee not manager'

    context 'when data is valid' do
      let(:new_employee) { company.employees.last }
      let(:employee_info) { JSON.parse(response.body) }

      context 'new employee info' do
        before { subject }

        it { is_expected.to have_http_status :success }
        it { expect(employee_info).to include({ "id" => new_employee.uuid }) }
        it { expect(employee_info).to include({ "name" => name }) }
        it { expect(employee_info).to include({ "email" => email }) }
        it { expect(employee_info).to include({ "teamName" => team.name }) }

        context 'when data is invalid' do
          let(:name) {}
          let(:team_id) {}

          it { is_expected.to have_http_status :success }
          it { expect(employee_info).to include({ "name" => ["can't be blank"] }) }
          it { expect(employee_info).to include({ "team" => ["must exist"] }) }
        end
      end
    end
  end

  describe '#update' do
    let(:updated_employee) { employees[0] }
    let(:name) { 'Updated employee' }
    let(:push_key) { 'the-key-to-success' }
    let(:params) { { name: name, push_key: push_key } }

    subject do
      put "/api/v3/employees/#{updated_employee.uuid}", params: params, headers: headers
      response
    end

    it_behaves_like 'invalid token'

    it_behaves_like 'employee not manager'

    context 'when data is valid' do
      let(:employee_info) { JSON.parse(response.body) }

      context 'new employee info' do
        before { subject }

        it { is_expected.to have_http_status :success }
        it { expect(employee_info).to include({ "id" => updated_employee.reload.uuid }) }
        it { expect(employee_info).to include({ "name" => updated_employee.reload.name }) }
        it { expect(employee_info).to include({ "pushKey" => push_key }) }

        context 'when data is invalid' do
          let(:name) {}

          it { is_expected.to have_http_status :success }
          it { expect(employee_info).to include({ "name" => ["can't be blank"] }) }
        end
      end
    end
  end
end
