# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reply, type: :model do
  subject { build(:reply) }

  it { is_expected.to belong_to :vote }

  it { is_expected.to validate_presence_of(:description) }

  describe 'when creating a new reply' do
    it 'should send a reply email' do
      mailer = instance_double(ActionMailer::MessageDelivery, deliver_later: true)
      expect(FeedbackMailer).to receive(:reply_email).with(subject).and_return(mailer)

      subject.save!
    end
  end
end
