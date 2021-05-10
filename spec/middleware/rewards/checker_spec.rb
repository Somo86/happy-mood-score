# frozen_string_literal: true

require 'rails_helper'

describe Rewards::Checker do
  let!(:company) { create(:company) }
  let(:employee) { create(:employee, company: company) }
  let(:event) { create(:event, name: 'submit-article', value: 2) }
  let(:activity) { create(:activity, event: event, employee: employee) }

  describe '.acquired' do
    subject { described_class.acquired(activity) }

    it { is_expected.to be_empty }

    context 'when reward conditions are met' do
      let!(:condition) { create(:condition, event: event, operation: :counter, expression: :gte, value: 3) }
      let(:reward) { condition.rule.reward }

      before { 3.times { create(:activity, event: event, employee: employee) } }

      it { expect(employee.reward_ids).to eq employee.achievements.pluck(:reward_id) }
      it { expect(employee.achievements.count).to eq 1 }
    end

    context 'when at least one of the reward conditions is met' do
      let!(:condition) { create(:condition, event: event, operation: :counter, expression: :gte, value: 2) }
      let(:rule) { condition.rule }
      let(:reward) { condition.rule.reward }
      let(:rule2) { create(:rule, reward: reward) }
      let!(:condition2) { create(:condition, rule: rule2, event: event, operation: :counter, expression: :gte, value: 12) }

      before { 3.times { create(:activity, event: event, employee: employee) } }

      it { expect(employee.reward_ids).to eq employee.achievements.pluck(:reward_id) }
      it { expect(Achievement.count).to eq 1 }
    end

    context 'when none of the reward conditions are met' do
      let!(:condition) { create(:condition, event: event, operation: :counter, expression: :gte, value: 33) }
      let(:rule) { condition.rule }
      let(:reward) { condition.rule.reward }
      let(:rule2) { create(:rule, reward: reward) }
      let!(:condition2) { create(:condition, rule: rule2, event: event, operation: :counter, expression: :gte, value: 12) }

      before { 3.times { create(:activity, event: event, employee: employee) } }

      it { is_expected.to be_empty }
      it { expect(employee.reward_ids).to be_empty }
    end

    context 'when employee already has acquired this reward' do
      let!(:achievement) { create(:achievement, employee: employee, reward: reward) }

      context 'when conditions are met' do
        let!(:condition) { create(:condition, event: event, operation: :counter, expression: :gte, value: 2) }
        let(:rule) { condition.rule }
        let(:reward) { condition.rule.reward }
        let(:rule2) { create(:rule, reward: reward) }
        let!(:condition2) { create(:condition, rule: rule2, event: event, operation: :counter, expression: :gte, value: 3) }

        before { 3.times { create(:activity, event: event, employee: employee) } }

        it { is_expected.to be_empty }
        it { expect(employee.reward_ids).to eq employee.achievements.pluck(:reward_id) }
      end

      context 'when conditions are not met' do
        let!(:condition) { create(:condition, event: event, operation: :counter, expression: :gte, value: 33) }
        let(:rule) { condition.rule }
        let(:reward) { condition.rule.reward }

        before { 3.times { create(:activity, event: event, employee: employee) } }

        it { is_expected.to be_empty }
        it { expect(employee.reward_ids).to eq employee.achievements.pluck(:reward_id) }
      end
    end
  end
end
