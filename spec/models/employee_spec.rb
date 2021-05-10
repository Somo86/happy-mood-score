# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Employee, type: :model do
  subject { build(:employee) }

  it_behaves_like 'uuidable'

  it { is_expected.to belong_to(:user).optional }
  it { is_expected.to belong_to :company }
  it { is_expected.to belong_to :team }
  it { is_expected.to belong_to :language }

  it { is_expected.to have_many :achievements }
  it { is_expected.to have_many :activities }
  it { is_expected.to have_many :votes }
  it { is_expected.to have_many :replies }
  it { is_expected.to have_many :historical_logs }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_uniqueness_of(:slack_username).scoped_to(:company_id).case_insensitive }

  it { is_expected.to define_enum_for(:role).with_values({ employee: 0, manager: 1, admin: 2, god: 99 }) }

  describe '#reward_ids' do
    let(:employee) { create(:employee) }

    subject { employee.reward_ids }

    it { is_expected.to be_empty }
  end

  describe '#slack_enabled?' do
    let(:company) { create(:company) }
    let(:slack_username) {}
    let(:employee) { create(:employee, company: company, slack_username: slack_username) }

    subject { employee.slack_enabled? }

    context 'when company does not have enabled slack' do
      context 'when user has a slack username' do
        let(:slack_username) { 'gamma_ray' }

        it { is_expected.to be false }
      end

      context 'when user does not have a slack username' do
        it { is_expected.to be false }
      end
    end

    context 'when company has enabled slack' do
      let(:company) { create(:company, :with_slack) }

      context 'when user has a slack username' do
        let(:slack_username) { 'gamma_ray' }

        it { is_expected.to be true }
      end

      context 'when user does not have a slack username' do
        it { is_expected.to be false }
      end
    end
  end
end
