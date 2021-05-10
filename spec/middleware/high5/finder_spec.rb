# frozen_string_literal: true

require 'rails_helper'

RSpec.describe High5::Finder do
  let(:company) { create(:company) }
  let(:employee) { create(:employee, company: company) }
  let(:employee2) { create(:employee, company: company) }
  let(:sender) { create(:employee, company: company) }
  let(:params) { {} }
  let(:filter) { described_class.new(company, params) }

  before do
    create(:activity, :high5, sender: sender, employee: employee, created_at: 5.months.ago)
    create(:activity, :high5, sender: sender, employee: employee2, created_at: 2.weeks.ago)
    create(:activity, :high5, sender: sender, employee: employee)
    create(:activity, :high5, sender: sender, employee: employee2)
    create(:activity, :high5, employee: employee, created_at: 1.year.ago)
  end

  describe '#all' do
    subject { filter.all.count }

    context 'when there is no filter' do
      it { is_expected.to eql 5 }
    end

    context 'when filtered by sender' do
      let(:params) { { sender_id: sender.id } }

      it { is_expected.to eql 4 }
    end

    context 'when filtered by employee' do
      let(:params) { { receiver_id: employee.id } }

      it { is_expected.to eql 3 }
    end

    context 'when start date is present' do
      let(:params) { { start_date: 1.week.ago.strftime('%Y-%m-%d') } }

      it { is_expected.to eql 2 }
    end

    context 'when end date is present' do
      let(:params) { { end_date: 2.week.ago.strftime('%Y-%m-%d') } }

      it { is_expected.to eql 3 }
    end

    context 'when start and end date are present' do
      let(:params) { { start_date: 2.years.ago.strftime('%Y-%m-%d') } }
      let(:params) { { end_date: 4.months.ago.strftime('%Y-%m-%d') } }

      it { is_expected.to eql 2 }
    end
  end
end
