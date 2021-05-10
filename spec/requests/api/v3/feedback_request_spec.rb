# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API Feedback' do
  let(:employee) { create(:employee, :manager) }
  let(:token) { employee.api_key }
  let(:company) { employee.company }
  let!(:votes) { create_list(:vote, 3, :voted, employee: employee, company: company) }
  let(:standard) { create(:employee, company: company) }
  let!(:other_votes) { create_list(:vote, 3, company: company, employee: standard) }
  let(:headers) { { 'ACCEPT' => 'application/json', 'Authorization' => "Bearer #{token}" } }

  describe '#index' do
    subject do
      get '/api/v3/feedback', headers: headers
      response
    end

    it_behaves_like 'invalid token'

    context 'when employee is manager' do
      let(:feedback_list) { JSON.parse(response.body) }

      before { subject }

      it { is_expected.to have_http_status :success }

      it { expect(feedback_list).to include(a_hash_including({ "id" => votes[0].uuid })) }
      it { expect(feedback_list).to include(a_hash_including({ "id" => votes[1].uuid })) }
      it { expect(feedback_list).to include(a_hash_including({ "id" => votes[2].uuid })) }
      it { expect(feedback_list).to include(a_hash_including({ "id" => other_votes[0].uuid })) }
      it { expect(feedback_list).to include(a_hash_including({ "id" => other_votes[1].uuid })) }
      it { expect(feedback_list).to include(a_hash_including({ "id" => other_votes[2].uuid })) }
    end

    context 'when employee is not a manager' do
      let(:token) { standard.api_key }
      let(:feedback_list) { JSON.parse(response.body) }

      before { subject }

      it { is_expected.to have_http_status :success }

      it { expect(feedback_list).to_not include(a_hash_including({ "id" => votes[0].uuid })) }
      it { expect(feedback_list).to_not include(a_hash_including({ "id" => votes[1].uuid })) }
      it { expect(feedback_list).to_not include(a_hash_including({ "id" => votes[2].uuid })) }
      it { expect(feedback_list).to include(a_hash_including({ "id" => other_votes[0].uuid })) }
      it { expect(feedback_list).to include(a_hash_including({ "id" => other_votes[1].uuid })) }
      it { expect(feedback_list).to include(a_hash_including({ "id" => other_votes[2].uuid })) }
    end
  end

  describe '#create' do
    let(:vote) { create(:vote, company: company) }
    let(:vote_token) { vote.token  }
    let(:status) { 'fine' }
    let(:message) { 'Every breath you take' }
    let(:params) { { token: vote_token, status: status, message: message } }
    let(:feedback_result) { JSON.parse(response.body) }

    subject do
      post '/api/v3/feedback', params: params, headers: headers
      response
    end

    it_behaves_like 'invalid token'

    context 'when data is valid' do
      context 'new feedback info' do
        before { subject }

        context 'when employee is manager' do
          it { is_expected.to have_http_status :success }
          it { expect(feedback_result).to include({ "id" => vote.uuid }) }
          it { expect(feedback_result).to include({ "token" => nil }) }
          it { expect(feedback_result).to include({ "employeeId" => vote.employee.uuid }) }
          it { expect(feedback_result).to include({ "employeeName" => vote.employee.name }) }
          it { expect(feedback_result).to include({ "isNew" => true }) }
          it { expect(feedback_result).to include({ "message" => message }) }
        end

        context 'when data is invalid' do
          context 'when token is not present' do
            let(:vote_token) {}

            it { is_expected.to have_http_status :not_found }
          end

          context 'when result is not present' do
            let(:status) {}

            it { subject; expect(feedback_result).to include({ "result" => ["can't be blank"] }) }
          end
        end
      end
    end
  end
end
