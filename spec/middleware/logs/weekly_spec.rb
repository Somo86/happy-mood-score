require 'rails_helper'

RSpec.describe Logs::Weekly do
  describe '.generate' do
    let(:company) { create(:company) }
    let(:employee) { company.employees.first }
    let(:team) { employee.team }
    let(:date) { Date.current }
    let(:start_date) { date.beginning_of_week }
    let(:end_date) { date.end_of_week }

    it 'should update all 3 entities' do
      allow(Logs::Employee).to receive(:update).with(start_date, end_date, employee)
      allow(Logs::Team).to receive(:update).with(start_date, end_date, team)
      allow(Logs::Company).to receive(:update).with(start_date, end_date, company)
      allow(Logs::Ranking).to receive(:update_team).with(start_date, team)
      allow(Logs::Ranking).to receive(:update_company).with(start_date, company)

      described_class.generate(date)
    end
  end
end
