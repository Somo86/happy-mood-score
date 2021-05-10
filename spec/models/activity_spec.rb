# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Activity, type: :model do
  subject { build(:activity) }

  it_behaves_like 'uuidable'

  it { is_expected.to belong_to :event }
  it { is_expected.to belong_to :employee }

  describe 'when creating a new activity' do
    let(:employee) { create(:employee) }
    let(:event) { create(:event, :vote, company: employee.company, value: 55) }
    subject { create(:activity, employee: employee, event: event) }

    it { expect { subject }.to change { Employee.find(employee.id).points }.by(event.value) }

    context 'when is a high 5' do
      let(:sender) { create(:employee) }
      let(:event) { create(:event, :high5) }
      subject { build(:activity, employee: employee, sender: sender, event: event) }

      it 'should send an email' do
        mailer = instance_double(ActionMailer::MessageDelivery, deliver_later: true)
        expect(ActivityMailer).to receive(:new_high5).with(subject).and_return(mailer)

        subject.save!
      end

      context 'when sender is not present' do
        let(:sender) {}

        it { expect(subject.save).to be false }

        it 'should return an error message' do
          subject.save

          expect(subject.errors.messages[:sender_id]).to eql ["can't be blank"]
        end
      end
    end

    context 'when is not a high 5' do
      let(:sender) { create(:employee) }
      let(:event) { create(:event, :feedback) }
      subject { build(:activity, sender: sender, event: event) }

      it 'should not email the employee' do
        expect(ActivityMailer).to receive(:new_high5).never

        subject.save!
      end
    end
  end
end
