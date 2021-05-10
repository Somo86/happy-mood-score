# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Employees::Finder do
  let(:company) { create(:company) }
  let(:params) { {} }
  let(:finder) { described_class.new(company, params) }
  let(:team) { create(:team, company: company) }

  before do
    create(:employee, company: company, name: 'Peter Wagner')
    create_list(:employee, 2, company: company)
    create_list(:employee, 2, company: company, team: team)
    create_list(:employee, 4, :archived, company: company)
  end

  describe '#all' do
    subject { finder.all.count }

    context 'when there are no params' do
      it { is_expected.to eql(6) }
    end

    context 'when filter by archived' do
      let(:params) { { archived: 1 } }

      it { is_expected.to eql(4) }
    end

    context 'when filtered by name' do
      let(:params) { { name: 'peter' } }

      it { is_expected.to eql(1) }
    end

    context 'when filtered by team' do
      let(:params) { { team_id: team.id } }

      it { is_expected.to eql(2) }
    end
  end
end
