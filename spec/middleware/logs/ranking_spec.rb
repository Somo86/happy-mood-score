require 'rails_helper'

RSpec.describe Logs::Ranking do
  let(:company) { create(:company) }
  let(:team) { create(:team, company: company) }
  let(:other_team) { create(:team, company: company) }
  let!(:first) { create(:employee, team: team, company: company, involvement: 99) }
  let!(:last) { create(:employee, team: team, company: company, involvement: 1) }
  let(:date) { Date.current }

  before do
    create_list(:employee, 2, team: team, company: company, involvement: rand(80) + 2)
    create_list(:employee, 3, company: company, team: other_team, involvement: rand(40) + 2)
    company.employees.each { |employee| create(:historical_log, employee: employee, generated_on: Date.current) }
    create(:historical_log, team: team, generated_on: Date.current)
    create(:historical_log, company: company, generated_on: Date.current)
  end

  describe '.update_team' do
    subject { described_class.update_team(team, date) }

    it 'should rank first employee as #1' do
      subject

      expect(first.historical_logs.last.team_ranking).to eql 1
    end

    it 'should rank last employee as #4' do
      subject

      expect(last.historical_logs.last.team_ranking).to eql 4
    end

    it 'should update total employees for the team' do
      subject

      expect(team.historical_logs.last.active_employees).to eql 4
    end
  end

  describe '.update_company' do
    subject { described_class.update_company(company, date) }

    it 'should rank first employee as #1' do
      subject

      expect(first.historical_logs.last.company_ranking).to eql 1
    end

    it 'should rank second to last as #7' do
      subject

      expect(last.historical_logs.last.company_ranking).to eql 7
    end

    it 'should rank lower involvement as #8' do
      subject
      admin = company.admin

      expect(admin.historical_logs.last.company_ranking).to eql 8
    end

    it 'should update total employees for the company' do
      subject

      expect(company.historical_logs.last.active_employees).to eql 8
    end
  end
end
