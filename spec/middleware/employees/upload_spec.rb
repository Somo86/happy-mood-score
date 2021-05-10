# frozen_string_literal: true

require 'rails_helper'

describe Employees::Upload do
  let(:admin) { create(:employee, :admin) }
  let(:employees_file) { file_fixture('employees.csv') }
  let!(:upload) { described_class.new(employees_file, admin) }

  describe '.import' do
    subject { upload.import }

    it { expect { subject }.to change { Employee.count }.by(4) }
    it { expect { subject }.to change { Team.count }.by(2) }
    it { is_expected.to include(["employee4@email.com", "Employee with error", "Team B", nil, nil, nil]) }

    context 'new teams' do
      before { subject }

      it { expect(Team.find_by(name: 'Team A')).to be_present }
      it { expect(Team.find_by(name: 'Team A').employees_count).to eql 3 }
      it { expect(Team.find_by(name: 'Team B')).to be_present }
      it { expect(Team.find_by(name: 'Team B').employees_count).to eql 1 }
    end
  end
end
