# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Counters::Update do
  let(:result) { 20 }
  let(:employee) { create(:employee) }
  let(:company) { employee.company }
  let(:sender) { create(:employee, company: company) }
  let(:vote) { build(:vote, :voted, result: result, employee: employee, team: employee.team, company: company) }

  describe '.new_feedback' do
    subject { described_class.new_feedback(vote) }

    it { expect { subject }.to change { Employee.find(vote.employee_id).comments }.by(1) }
    it { expect { subject }.to change { Team.find(vote.team_id).comments }.by(1) }
    it { expect { subject }.to change { Company.find(vote.company_id).comments }.by(1) }
  end

  describe '.new_high5' do
    subject { described_class.new_high5(sender, employee) }

    it { expect { subject }.to change { Company.find(sender.company.id).high5_total }.by(1) }
    it { expect { subject }.to change { Employee.find(sender.id).high5_given }.by(1) }
    it { expect { subject }.to change { Employee.find(employee.id).high5_received }.by(1) }
    it { expect { subject }.to change { Team.find(sender.team.id).high5_given }.by(1) }
    it { expect { subject }.to change { Team.find(employee.team.id).high5_received }.by(1) }
  end

  describe '.new_result' do
    subject { described_class.new_result(vote) }

    context 'when vote is good' do
      let(:result) { 30 }
      it { expect { subject }.to change { Employee.find(vote.employee_id).results_good }.by(1) }
      it { expect { subject }.to change { Team.find(vote.team_id).results_good }.by(1) }
      it { expect { subject }.to change { Company.find(vote.company_id).results_good }.by(1) }
      it { expect { subject }.to change { Employee.find(vote.employee_id).results_fine }.by(0) }
      it { expect { subject }.to change { Employee.find(vote.employee_id).results_fine }.by(0) }
      it { expect { subject }.to change { Team.find(vote.team_id).results_fine }.by(0) }
      it { expect { subject }.to change { Company.find(vote.company_id).results_bad }.by(0) }
      it { expect { subject }.to change { Team.find(vote.team_id).results_bad }.by(0) }
      it { expect { subject }.to change { Company.find(vote.company_id).results_bad }.by(0) }
    end

    context 'when vote is fine' do
      let(:result) { 20 }
      it { expect { subject }.to change { Employee.find(vote.employee_id).results_good }.by(0) }
      it { expect { subject }.to change { Team.find(vote.team_id).results_good }.by(0) }
      it { expect { subject }.to change { Company.find(vote.company_id).results_good }.by(0) }
      it { expect { subject }.to change { Employee.find(vote.employee_id).results_fine }.by(1) }
      it { expect { subject }.to change { Employee.find(vote.employee_id).results_fine }.by(1) }
      it { expect { subject }.to change { Team.find(vote.team_id).results_fine }.by(1) }
      it { expect { subject }.to change { Company.find(vote.company_id).results_bad }.by(0) }
      it { expect { subject }.to change { Team.find(vote.team_id).results_bad }.by(0) }
      it { expect { subject }.to change { Company.find(vote.company_id).results_bad }.by(0) }
    end

    context 'when vote is bad' do
      let(:result) { 10 }
      it { expect { subject }.to change { Employee.find(vote.employee_id).results_good }.by(0) }
      it { expect { subject }.to change { Team.find(vote.team_id).results_good }.by(0) }
      it { expect { subject }.to change { Company.find(vote.company_id).results_good }.by(0) }
      it { expect { subject }.to change { Employee.find(vote.employee_id).results_fine }.by(0) }
      it { expect { subject }.to change { Employee.find(vote.employee_id).results_fine }.by(0) }
      it { expect { subject }.to change { Team.find(vote.team_id).results_fine }.by(0) }
      it { expect { subject }.to change { Company.find(vote.company_id).results_bad }.by(1) }
      it { expect { subject }.to change { Team.find(vote.team_id).results_bad }.by(1) }
      it { expect { subject }.to change { Company.find(vote.company_id).results_bad }.by(1) }
    end
  end
end
