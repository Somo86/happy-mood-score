# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Employees::Feedback do
  let(:company) { create(:company, :with_slack, next_request_at: 5.minutes.from_now) }
  let!(:with_slack) { create(:employee, company: company, slack_username: 'Finntroll') }

  describe '.request' do
    subject { described_class.request(company) }

    it { expect { subject }.to change { Vote.count }.by(2) }

    it 'should notifiy employee via slack' do
      expect(Slack::Feedback).to receive(:request).once

      subject
    end

    it 'should notifiy employee via email' do
      expect(FeedbackMailer).to receive(:request_email).once

      subject
    end
  end
end
