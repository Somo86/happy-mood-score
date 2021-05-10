# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notes::Finder do
  let(:company) { create(:company) }
  let(:employee) { create(:employee, company: company) }
  let(:employee2) { create(:employee, company: company) }
  let(:params) { {} }
  let(:filter) { described_class.new(employee, params) }
  before do
    create_list(:note, 6, employee: employee)
    create_list(:note, 4, :closed, employee: employee)
    create_list(:note, 3, receiver: employee2, employee: employee)
  end

  describe '#all' do
    subject { filter.all.count }

    context 'when there is no filter' do
      it { is_expected.to eql 9 }
    end

    context 'when filtered by closed' do
      let(:params) { { closed: '1' } }

      it { is_expected.to eql 4 }
    end

    context 'when filtered by employee' do
      let(:params) { { receiver_id: employee2.id } }

      it { is_expected.to eql 3 }
    end
  end
end
