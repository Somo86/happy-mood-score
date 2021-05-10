# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Company, type: :model do
  subject { build(:company) }

  it { is_expected.to belong_to :language }
  it { is_expected.to have_many :rewards }
  it { is_expected.to have_many :events }
  it { is_expected.to have_many :employees }
  it { is_expected.to have_many :teams }
  it { is_expected.to have_many :votes }
  it { is_expected.to have_many :polls }
  it { is_expected.to have_many :historical_logs }
  it { is_expected.to have_many(:users).through(:employees) }
  it { is_expected.to have_many(:activities).through(:employees) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }

  it { is_expected.to validate_uniqueness_of(:slug).case_insensitive }

  it { should define_enum_for(:frequency).with_values(%i[daily weekly monthly]) }
  it { should define_enum_for(:weekday).with_values(%i[monday tuesday wednesday thursday friday]) }

  describe 'before save' do
    let(:next_request_at) {}
    let(:company) { create(:company, next_request_at: next_request_at) }

    subject { company.update(params) }

    context 'when company does not have an active delivery' do
      let(:params) {  { weekday: 'monday' } }

      it 'should not re-enqueue the current job' do
        expect { subject }.to_not change { company.reload.next_request_at }
      end
    end

    context 'when company has an active delivery' do
      let(:next_request_at) { 123.days.from_now }

      context 'when delivery params have changed' do
        let(:params) {  { frequency: 'monthly' } }

        it 'should update the request date' do
          expect { subject }.to change { company.reload.next_request_at }
        end
      end

      context 'when delivery params have not changed' do
        let(:params) {  { name: 'In Flames' } }

        it 'should not update the request date' do
          expect { subject }.to_not change { company.reload.next_request_at }
        end
      end
    end
  end

  describe '#slack_enabled?' do
    let(:slack_token) {}
    let(:slack_team_id) {}
    let(:company) { create(:company, slack_token: slack_token, slack_team_id: slack_team_id) }

    subject { company.slack_enabled? }

    context 'when company does not have a token nor a team id' do
      it { is_expected.to be false }
    end

    context 'when company has a token but not a team id' do
      let(:slack_token) { 'token-doken' }

      it { is_expected.to be false }
    end

    context 'when company does not have a token but has a team id' do
      let(:slack_team_id) { 'Blut im Auge' }

      it { is_expected.to be false }
    end

    context 'when company does not have a token but has a team id' do
      let(:slack_token) { 'token-doken' }
      let(:slack_team_id) { 'Blut im Auge' }

      it { is_expected.to be true }
    end
  end
end
