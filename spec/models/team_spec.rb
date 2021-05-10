# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Team, type: :model do
  subject { build(:team) }

  it { is_expected.to belong_to :company }

  it { is_expected.to have_many :employees }
  it { is_expected.to have_many :votes }
  it { is_expected.to have_many :historical_logs }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:company_id).case_insensitive }

  describe 'only active employees' do
    let(:team) { create(:team) }
    let!(:employee) { create(:employee, team: team) }
    let!(:archived_employee) { create(:employee, :archived, team: team) }

    subject { team.employees.to_a }

    it { is_expected.to include employee }
    it { is_expected.to_not include archived_employee }

    context 'size of employees count' do
      it { expect(team.employees.size).to eql 1 }
    end
  end
end
