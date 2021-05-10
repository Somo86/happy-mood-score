# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Activities::High5 do
  let(:description) {}
  let(:receiver) { create(:employee) }
  let(:company) { receiver.company }
  let(:sender) { create(:sender, company: company) }
  let(:high5) { company.events.high5.first }

  describe '.create' do
    subject { described_class.create(sender, receiver, description) }

    context 'when there is a description' do
      let(:description) { 'The leaf on the oak of Far' }

      its(:description) { is_expected.to eql description }
    end

    its(:description) { is_expected.to be_nil }
    its(:employee_id) { is_expected.to eql receiver.id }
    its(:sender_id) { is_expected.to eql sender.id }
    its(:value) { is_expected.to eql high5.value }

    it 'should update the counters' do
      expect(Counters::Update).to receive(:new_high5).with(sender, receiver)
      subject
    end
  end
end
