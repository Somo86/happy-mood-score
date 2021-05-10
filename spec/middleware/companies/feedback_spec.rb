# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Companies::Feedback do
  let(:next_request_at) {}
  let(:deleted_at) {}
  let(:company) { create(:company, next_request_at: next_request_at, deleted_at: deleted_at) }

  describe '.request' do
    subject { described_class.request }

    context 'when company has feedback request enabled' do
      context 'when time is in range for request' do
        let(:next_request_at) { 5.minutes.ago }

        before { expect(Employees::Feedback).to receive(:request).with(company) }

        it { expect { subject }.to change { company.reload.next_request_at } }
      end

      context 'when time is not in range for request' do
        let(:next_request_at) { 15.minutes.ago }

        before { expect(Employees::Feedback).to_not receive(:request) }

        it { expect { subject }.to_not change { company.reload.next_request_at } }
      end
    end

    context 'when when company does not have feedback request enabled' do
      before { expect(Employees::Feedback).to_not receive(:request) }

      context 'when company is active' do
        it { expect { subject }.to_not change { company.reload.next_request_at } }
      end

      context 'when company has been deleted' do
        let(:deleted_at) { 4.days.ago }

        it { expect { subject }.to_not change { company.reload.next_request_at } }
      end
    end
  end
end
