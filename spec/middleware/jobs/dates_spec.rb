# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Jobs::Dates do
  let(:hour) { '19:30' }
  let(:weekday) { 'wednesday' }
  let(:company) { create(:company, hour: hour, weekday: weekday) }
  let(:job_dates) { described_class.new(company) }

  describe '.next_request' do
    subject { job_dates.next_request }

    before { company.update(weekday: weekday) }

    after { travel_back }

    context 'when frequency is monthly' do
      let(:weekday) { 'friday' }
      before { company.update(frequency: 'monthly') }

      context 'when current date is lower than selected' do
        before { travel_to ActiveSupport::TimeZone[company.timezone].parse('2020-06-09 12:59:59') }

        it { is_expected.to eql ActiveSupport::TimeZone[company.timezone].parse('2020-06-26 19:30:00') }
      end

      context 'when current date is selected' do
        context 'when time is lower' do
          before { travel_to ActiveSupport::TimeZone[company.timezone].parse('2020-06-26 12:59:59') }

          it { is_expected.to eql ActiveSupport::TimeZone[company.timezone].parse('2020-06-26 19:30:00') }
        end

        context 'when time is higher' do
          before { travel_to ActiveSupport::TimeZone[company.timezone].parse('2020-06-26 19:59:59') }

          it { is_expected.to eql ActiveSupport::TimeZone[company.timezone].parse('2020-07-31 19:30:00') }
        end
      end

      context 'when current date is higher than selected' do
        before { travel_to ActiveSupport::TimeZone[company.timezone].parse('2020-06-29 12:59:59') }

        it { is_expected.to eql ActiveSupport::TimeZone[company.timezone].parse('2020-07-31 19:30:00') }
      end
    end

    context 'when frequency is weekly' do
      context 'when current date is lower than selected' do
        before { travel_to ActiveSupport::TimeZone[company.timezone].parse('2020-06-09 12:59:59') }

        it { is_expected.to eql ActiveSupport::TimeZone[company.timezone].parse('2020-06-10 19:30:00') }
      end

      context 'when current date is higher than selected' do
        before { travel_to ActiveSupport::TimeZone[company.timezone].parse('2020-06-11 12:59:59') }

        it { is_expected.to eql ActiveSupport::TimeZone[company.timezone].parse('2020-06-17 19:30:00') }
      end

      context 'when current date is same day' do
        context 'when hour is lower than selected' do
          before { travel_to ActiveSupport::TimeZone[company.timezone].parse('2020-06-17 12:59:59') }

          it { is_expected.to eql ActiveSupport::TimeZone[company.timezone].parse('2020-06-17 19:30:00') }
        end

        context 'when hour is higher than selected' do
          before { travel_to ActiveSupport::TimeZone[company.timezone].parse('2020-06-17 19:30:59') }

          it { is_expected.to eql ActiveSupport::TimeZone[company.timezone].parse('2020-06-24 19:30:00') }
        end
      end
    end

    context 'when frequency is daily' do
      before { company.update(frequency: 'daily') }

      context 'when current date is sunday' do
        before { travel_to ActiveSupport::TimeZone[company.timezone].parse('2021-04-04 12:59:59') }

        it { is_expected.to eql ActiveSupport::TimeZone[company.timezone].parse('2021-04-05 19:30:00') }
      end

      context 'when current date is monday' do
        before { travel_to ActiveSupport::TimeZone[company.timezone].parse('2020-02-10 12:21:21') }

        it { is_expected.to eql ActiveSupport::TimeZone[company.timezone].parse('2020-02-10 19:30:00') }
      end

      context 'when current date is tuesday' do
        before { travel_to ActiveSupport::TimeZone[company.timezone].parse('2019-12-31 20:00:00') }

        it { is_expected.to eql ActiveSupport::TimeZone[company.timezone].parse('2020-01-01 19:30:00') }
      end

      context 'when current date is wednesday' do
        before { travel_to ActiveSupport::TimeZone[company.timezone].parse('2020-07-01 20:58:00') }

        it { is_expected.to eql ActiveSupport::TimeZone[company.timezone].parse('2020-07-02 19:30:00') }
      end

      context 'when current date is thursday' do
        before { travel_to ActiveSupport::TimeZone[company.timezone].parse('2020-08-12 02:59:00') }

        it { is_expected.to eql ActiveSupport::TimeZone[company.timezone].parse('2020-08-12 19:30:00') }
      end

      context 'when current date is friday' do
        context 'when hour is lower than expected' do
          before { travel_to ActiveSupport::TimeZone[company.timezone].parse('2020-08-28 07:00:00') }
          let(:hour) { '09:00' }

          it { is_expected.to eql ActiveSupport::TimeZone[company.timezone].parse('2020-08-28 09:00:00') }
        end

        context 'when hour is greater than expected' do
          before { travel_to ActiveSupport::TimeZone[company.timezone].parse('2020-08-28 17:03:00') }
          let(:hour) { '17:00' }

          it { is_expected.to eql ActiveSupport::TimeZone[company.timezone].parse('2020-08-31 17:00:00') }
        end
      end
    end
  end
end
