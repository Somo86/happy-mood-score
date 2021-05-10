# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Feedback::Finder do
  let(:company) { create(:company) }
  let(:employee) { create(:employee, company: company) }
  let(:params) { {} }
  let(:filter) { described_class.new(employee, params) }

  before do
    create(:vote, :voted, company: company, team: employee.team, employee: employee)
    create(:vote, :voted, company: company, team: employee.team)
    create(:vote, :voted, company: company, team: employee.team)
    create(:vote, :voted, company: company)
    create(:vote, :old, company: company, team: employee.team)
    create(:vote, :old, company: company, team: employee.team)
    create(:vote, :old, company: company)
    create(:vote, company: company, team: employee.team)
    create(:vote, company: company)
  end

  describe '#all' do
    subject { filter.all.count }

    context 'when there is no filter' do
      it { is_expected.to eql 7 }
    end

    context 'when filtered by all' do
      let(:params) { { all: 1 } }

      it { is_expected.to eql 9 }
    end

    context 'when filtered by new' do
      let(:params) { { new: 1 } }

      it { is_expected.to eql 4 }
    end

    context 'when filtered by employee' do
      let(:params) { { employee_id: employee.id } }

      it { is_expected.to eql 1 }
    end

    context 'when filtered by team_id' do
      let(:team) { create(:team, company: company) }
      let(:params) { { team_id: team.id } }

      before do
        create(:vote, :voted, company: company, team: team)
        create(:vote, :voted, company: company, team: team)
      end

      it { is_expected.to eql 2 }
    end

    context 'when filtered by employee and new' do
      let(:params) { { new: 1, employee_id: employee.id } }

      it { is_expected.to eql 1 }
    end
  end
end
