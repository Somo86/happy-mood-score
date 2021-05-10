# frozen_string_literal: true

module Jobs
  class Dates
    def initialize(company)
      @company = company
    end

    def next_request
      case company.frequency
      when 'daily'
        next_work_day
      when 'weekly'
        next_week_day
      when 'monthly'
        next_month_day
      end
    end

    private

    attr_reader :company

    def next_work_day
      current_time = current_time_in_company_timezone
      schedule_time = delivery_time_in_company_timezone(current_time)

      if working_days.include?(current_time.wday) && current_time < schedule_time
        schedule_time
      elsif !working_days.include?(current_time.wday) || current_time.wday == 5
        schedule_time.next_occurring(:monday)
      else
        schedule_time + 1.day
      end
    end

    def next_week_day
      current_time = current_time_in_company_timezone
      schedule_time = delivery_time_in_company_timezone(current_time)

      if current_time.wday == company_requested_day && current_time < schedule_time
        schedule_time
      else
        schedule_time.next_occurring(company.weekday.to_sym)
      end
    end

    def next_month_day
      current_time = current_time_in_company_timezone
      schedule_time = delivery_time_in_company_timezone(current_time, true)

      if current_time > schedule_time
        last_weekday_of_month(schedule_time + 1.month)
      else
        last_weekday_of_month(schedule_time)
      end
    end

    def company_requested_day
      %w[sunday monday tuesday wednesday thursday friday saturday].index(company.weekday)
    end

    def working_days
      (1..5)
    end

    def current_time_in_company_timezone
      Time.current.in_time_zone(company.timezone)
    end

    def delivery_time_in_company_timezone(current_time, end_of_month=false)
      current_time = last_weekday_of_month(current_time) if end_of_month
      date = current_time.strftime("%Y-%m-%d")

      ActiveSupport::TimeZone[company.timezone].parse("#{date} #{company.hour}")
    end

    def last_weekday_of_month(current_time)
      current_time = current_time.end_of_month
      current_time = current_time.prev_occurring(company.weekday.to_sym) if current_time.wday != company_requested_day
      date = current_time.strftime("%Y-%m-%d")

      ActiveSupport::TimeZone[company.timezone].parse("#{date} #{company.hour}")
    end
  end
end
