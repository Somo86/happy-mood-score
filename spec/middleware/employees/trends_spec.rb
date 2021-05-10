# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Employees::Trends do
  let(:employee) { create(:employee) }

  describe '.generate' do
    subject { described_class.generate(employee) }

    context 'when there are no historical logs' do
      let(:response) do
        {
          high5_received: { total: 0, variation: 0 },
          high5_given: { total: 0, variation: 0 },
          hms: { total: 0, variation: 0 },
          involvement: { total: 0, variation: 0 },
          comments: { total: 0, variation: 0 },
          company_ranking: { total: 0, variation: 0, hms: 0, involvement: 0, total_employees: 2 },
          team_ranking: { total: 0, variation: 0, hms: 0, involvement: 0, total_employees: 1 },
          last_vote: nil
        }
      end


      it { is_expected.to eql response }
    end

    context 'when there is one historical log' do
      before { employee.historical_logs.delete_all }

      let!(:vote) { create(:vote, :voted, result: 10, employee: employee) }

      let!(:last_log) do
        create(
          :historical_log,
          employee: employee,
          high5_received: 8,
          high5_given: 2,
          hms: 3,
          involvement: 56,
          comments: 7,
          company_ranking: 4,
          team_ranking: 2
        )
      end
      let(:response) do
        {
          high5_received: { total: 8, variation: 8 },
          high5_given: { total: 2, variation: 2 },
          hms: { total: 3, variation: 3 },
          involvement: { total: 56, variation: 56 },
          comments: { total: 7, variation: 7 },
          company_ranking: { total: 4, variation: -4, hms: -10, involvement: 100, total_employees: 2 },
          team_ranking: { total: 2, variation: -2, hms: -10, involvement: 100, total_employees: 1 },
          last_vote: vote
        }
      end

      it { is_expected.to eql response }
    end

    context 'when there is more than one historical log' do
      let!(:vote) { create(:vote, :voted, result: 20, employee: employee) }

      before do
        create(
          :historical_log,
          employee: employee,
          high5_received: 8,
          high5_given: 2,
          hms: 3,
          involvement: 55,
          comments: 7,
          company_ranking: 4,
          team_ranking: 2,
          generated_on: 3.days.ago
        )
        create(
          :historical_log,
          employee: employee,
          high5_received: 18,
          high5_given: 1,
          hms: 4.45,
          involvement: 55.99,
          comments: 4,
          company_ranking: 7,
          team_ranking: 4,
          generated_on: 11.days.ago
        )
      end
      let(:response) do
        {
          high5_received: { total: 8, variation: -10 },
          high5_given: { total: 2, variation: 1 },
          hms: { total: 3, variation: -1 },
          involvement: { total: 55, variation: 0 },
          comments: { total: 7, variation: 3 },
          company_ranking: { total: 4, variation: 3, hms: 5, involvement: 100, total_employees: 2 },
          team_ranking: { total: 2, variation: 2, hms: 5, involvement: 100, total_employees: 1 },
          last_vote: vote
        }
      end

      it { is_expected.to eql response }
    end
  end
end
