# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Company, type: :model do
  let(:company) { create(:company) }
  let(:employee) { create(:employee, company: company) }
  let(:team) { employee.team }
  let(:result) {}
  let(:description) {}

  subject { create(:vote, employee: employee, team: team, company: company, result: result, description: description) }

  it { is_expected.to belong_to :company }
  it { is_expected.to belong_to :team }
  it { is_expected.to belong_to :employee }

  it { is_expected.to have_many :replies }

  it { is_expected.to validate_inclusion_of(:result).in_array([10, 20, 30]) }
  it { is_expected.to validate_presence_of(:result).on(:update) }

  describe 'vote activity' do
    subject { build(:vote, employee: employee, team: team, company: company, result: result, description: description) }

    context 'new vote' do
      context 'when it does not have a result yet' do
        it 'should not create an activity' do
          expect(Activities::Vote).to receive(:new_result).never
          expect(Activities::Vote).to receive(:new_feedback).never

          subject.save!
        end
      end

      context 'when it does have a result' do
        let(:result) { 20 }

        it 'should create a new result activity' do
          expect(Activities::Vote).to receive(:new_result).with(subject)
          expect(Activities::Vote).to receive(:new_feedback).never

          subject.save!
        end
      end

      context 'when it does have a description' do
        let(:result) { 20 }
        let(:description) { 'A message' }

        it 'should create a new feedback activity' do
          expect(Activities::Vote).to receive(:new_result).with(subject)
          expect(Activities::Vote).to receive(:new_feedback).with(subject)

          subject.save!
        end
      end
    end

    context 'updated vote' do
      before { subject.save! }

      context 'when it saves other attributes' do
        it 'should not create an activity' do
          expect(Activities::Vote).to receive(:new_result).never
          expect(Activities::Vote).to receive(:new_feedback).never

          subject.update(token: 'other-token')
        end
      end

      context 'when result is updated' do
        it 'should create a new result activity' do
          expect(Activities::Vote).to receive(:new_result).with(subject)
          expect(Activities::Vote).to receive(:new_feedback).never

          subject.update(result: 10)
        end
      end

      context 'when description is updated' do
        let(:result) { 20 }

        it 'should create a new result activity' do
          expect(Activities::Vote).to receive(:new_result).never
          expect(Activities::Vote).to receive(:new_feedback).with(subject)

          subject.update(description: 'Some interesting message')
        end
      end
    end
  end
end
