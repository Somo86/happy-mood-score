# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Achievement, type: :model do
  it_behaves_like 'uuidable'

  it { is_expected.to belong_to :reward }
  it { is_expected.to belong_to :employee }

  describe 'new achievement' do
    let(:employee) { create(:employee) }
    let(:company) { employee.company }
    let(:level) { company.rewards.level.last }

    subject { build(:achievement, employee: employee, reward: level) }

    context 'when achievement is a new level' do
      it 'should update the employee level cache' do
        expect(employee).to receive(:update).with(level_name: level.name)

        subject.save!
      end
    end

    it 'should notify the employee with an email' do
      mailer = instance_double(ActionMailer::MessageDelivery, deliver_later: true)
      expect(AchievementMailer).to receive(:notify).with(subject).and_return(mailer)

      subject.save!
    end
  end
end
