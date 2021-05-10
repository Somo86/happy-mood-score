# frozen_string_literal: true

RSpec.describe Slack::Feedback do
  let(:vote) { create(:vote) }
  let(:response) { Net::HTTPSuccess.new(1.0, '200', 'OK') }
  let(:http) { double(Net::HTTP) }

  describe '#request' do
    subject { described_class.new(vote).request }

    before do
      allow(Net::HTTP).to receive(:new).and_return(http)
      allow(http).to receive(:use_ssl=)
      allow(http).to receive(:request).with(Net::HTTP::Post).and_return(response)
    end

    context 'when response is valid' do
      it { is_expected.to be true }
    end

    context 'when response is invalid' do
      let(:response) { Net::HTTPUnauthorized.new(1.0, '401', 'OK') }

      it { is_expected.to be false }
    end
  end
end
