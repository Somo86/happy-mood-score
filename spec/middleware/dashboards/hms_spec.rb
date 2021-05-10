# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dashboards::Hms do
  let(:votes) { { total: 10, bad: 1, fine: 3, good: 2 } }
  let(:hms) { described_class.new(votes) }

  describe '#calculate' do
    subject { hms.calculate }

    its(:first) { is_expected.to eql 4 }
    its(:last) { is_expected.to eql 60 }

    context 'when there are no votes' do
      let(:votes) { { total: 0, bad: 0, fine: 0, good: 0 } }

      its(:first) { is_expected.to eql 0 }
      its(:last) { is_expected.to eql 0 }
    end
  end
end
