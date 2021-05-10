# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rules::NewAccount do
  let(:company) do
    company = create(:company, name: 'Brand new')
    Rule.destroy_all
    company
  end

  describe '.setup!' do
    before { described_class.setup!(company) }

    it { expect { described_class.setup!(company) }.to change { Rule.count }.by(20) }

    context 'rules for feedback' do
      let(:feedback) { company.rewards.find_by(name: 'Feedback aficionado') }

      it { expect(feedback.rules.find_by(name: 'Feedback aficionado')).to be_present }
    end

    context 'rules for ideas' do
      let(:feedback) { company.rewards.find_by(name: 'Thomas Edison') }

      it { expect(feedback.rules.find_by(name: 'Thomas Edison')).to be_present }
    end

    context 'rules for levels' do
      let(:feedback) { company.rewards.find_by(name: 'Level 1') }

      it { expect(feedback.rules.find_by(name: 'Level 1')).to be_present }
    end
  end
end
