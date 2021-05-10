# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rewards::NewAccount do
  let(:company) do
    company = create(:company, name: 'Brand new')
    company.rewards.destroy_all
    company
  end

  describe '.setup!' do
    before { described_class.setup!(company) }

    context 'levels' do
      it { expect(company.rewards.find_by(name: 'Level 0')).to be_present }
      it { expect(company.rewards.find_by(name: 'Level 1')).to be_present }
      it { expect(company.rewards.find_by(name: 'Level 2')).to be_present }
      it { expect(company.rewards.find_by(name: 'Level 3')).to be_present }
      it { expect(company.rewards.find_by(name: 'Level 4')).to be_present }
      it { expect(company.rewards.find_by(name: 'Level 5')).to be_present }
      it { expect(company.rewards.find_by(name: 'Level 6')).to be_present }
      it { expect(company.rewards.find_by(name: 'Level 7')).to be_present }
      it { expect(company.rewards.find_by(name: 'Level 8')).to be_present }
      it { expect(company.rewards.find_by(name: 'Level 9')).to be_present }
      it { expect(company.rewards.find_by(name: 'Level 10')).to be_present }
    end

    context 'feedback' do
      it { expect(company.rewards.find_by(name: 'Feedback aficionado')).to be_present }
      it { expect(company.rewards.find_by(name: 'Feedback specialist')).to be_present }
      it { expect(company.rewards.find_by(name: 'Feedback lover')).to be_present }
      it { expect(company.rewards.find_by(name: 'Feedback expert')).to be_present }
      it { expect(company.rewards.find_by(name: 'Feedback king')).to be_present }
    end

    context 'ideas' do
      it { expect(company.rewards.find_by(name: 'Thomas Edison')).to be_present }
      it { expect(company.rewards.find_by(name: 'Leonardo Da Vinci')).to be_present }
      it { expect(company.rewards.find_by(name: 'Isaac Newton')).to be_present }
      it { expect(company.rewards.find_by(name: 'Albert Einstein')).to be_present }
      it { expect(company.rewards.find_by(name: 'Nikola Tesla')).to be_present }
    end
  end
end
