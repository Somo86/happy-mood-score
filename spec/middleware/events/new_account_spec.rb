# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Events::NewAccount do
  let(:company) do
    company = create(:company, name: 'Brand new')
    company.events.destroy_all
    company
  end

  describe '.setup!' do
    before { described_class.setup!(company) }

    it { expect(company.events.find_by(name: 'Hi5')).to be_present }
    it { expect(company.events.find_by(name: 'Feedback')).to be_present }
    it { expect(company.events.find_by(name: 'Vote')).to be_present }
    it { expect(company.events.find_by(name: 'Idea')).to be_present }
    it { expect(company.events.find_by(name: 'IdeaVote')).to be_present }
    it { expect(company.events.find_by(name: 'IdeaComment')).to be_present }
  end
end
