# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API High5' do
  let(:employee) { create(:employee, :manager) }
  let(:token) { employee.api_key }
  let(:company) { employee.company }
  let!(:activities) { create_list(:activity, 3, :high5, employee: employee) }
  let(:headers) { { 'ACCEPT' => 'application/json', 'Authorization' => "Bearer #{token}" } }

  describe '#index' do
    subject do
      get '/api/v3/high5', headers: headers
      response
    end

    it_behaves_like 'invalid token'

    it_behaves_like 'employee not manager'

    context 'when user is manager' do
      let(:high5_list) { JSON.parse(response.body) }

      before { subject }

      it { is_expected.to have_http_status :success }

      it { expect(high5_list).to include(a_hash_including({ "id" => activities[0].uuid })) }
      it { expect(high5_list).to include(a_hash_including({ "id" => activities[1].uuid })) }
      it { expect(high5_list).to include(a_hash_including({ "id" => activities[2].uuid })) }
    end
  end

  describe '#create' do
    let(:receiver) { create(:employee, company: company) }
    let(:sender) { create(:employee, company: company) }
    let(:message) { 'Every breath you take' }
    let(:sender_uuid) { sender.uuid }
    let(:receiver_uuid) { receiver.uuid }
    let(:params) { { receiver_id: receiver_uuid, sender_id: sender_uuid, message: message } }
    let(:high5_result) { JSON.parse(response.body) }
    let(:high5) { company.activities.high5s.last }

    subject do
      post '/api/v3/high5', params: params, headers: headers
      response
    end

    it_behaves_like 'invalid token'

    context 'when data is valid' do
      context 'new high5 info' do
        before { subject }

        context 'when user is manager' do
          it { is_expected.to have_http_status :success }
          it { expect(high5_result).to include({ "id" => high5.uuid }) }
          it { expect(high5_result).to include({ "senderId" => sender.uuid }) }
          it { expect(high5_result).to include({ "senderName" => sender.name }) }
          it { expect(high5_result).to include({ "receiverId" => receiver.uuid }) }
          it { expect(high5_result).to include({ "receiverName" => receiver.name }) }
          it { expect(high5_result).to include({ "message" => message }) }
        end

        context 'when data is invalid' do
          context 'when sender is not present' do
            let(:sender_uuid) {}

            it { is_expected.to have_http_status :not_found }
          end

          context 'when receiver is not present' do
            let(:receiver_uuid) {}

            it { is_expected.to have_http_status :not_found }
          end
        end
      end
    end
  end
end
