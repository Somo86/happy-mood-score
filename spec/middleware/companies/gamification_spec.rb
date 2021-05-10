# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Companies::Gamification do
  let(:company) { create(:company, name: 'Brand new') }

  describe '.setup!' do
    it 'should generate default rewards and events' do
      expect(Rewards::NewAccount).to receive(:setup!).with(company)
      expect(Events::NewAccount).to receive(:setup!).with(company)

      described_class.setup!(company)
    end
  end
end
