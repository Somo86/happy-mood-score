# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Activities::Vote do
  let(:description) {}
  let(:employee) { create(:employee) }
  let(:company) { employee.company }
  let(:vote_event) { company.events.vote.first }
  let(:vote) { create(:vote, :voted, employee: employee, company: company) }

  describe '.new_result' do
    subject { described_class.new_result(vote) }

    its(:event_id) { is_expected.to eql vote_event.id }
    its(:employee_id) { is_expected.to eql employee.id }
    its(:value) { is_expected.to eql vote_event.value }

    it 'should update the counters' do
      expect(Counters::Update).to receive(:new_result).with(vote)

      subject
    end
  end

  describe '.new_feedback' do
    let(:feedback_event) { company.events.feedback.first }

    subject { described_class.new_feedback(vote) }

    its(:event_id) { is_expected.to eql feedback_event.id }
    its(:employee_id) { is_expected.to eql employee.id }
    its(:value) { is_expected.to eql feedback_event.value }

    it 'should update the counters' do
      expect(Counters::Update).to receive(:new_feedback).with(vote)

      subject
    end
  end
end
