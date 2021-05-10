# frozen_string_literal: true

module ApplicationHelper
  def main_menu_class(current_item)
    if current_page?(current_item)
      'bg-gray-100 text-gray-900'
    else
      'bg-transparent text-gray-600'
    end
  end

  def tw_form_with(**args, &block)
    args.merge!({ builder: TailwindFormBuilder, ref: 'form' })

    form_with(**args, &block)
  end

  def time_with_timezone(date, company)
    company_date = ActiveSupport::TimeZone[company.timezone].parse(date.to_s)
    case company.date_format
    when 1
      company_date.strftime('%Y-%m-%d %H:%M')
    when 2
      company_date.strftime('%d-%m-%Y %H:%M')
    when 3
      company_date.strftime('%b-%-d-%Y %I:%M %p')
    end
  end

  def date_with_timezone(date, company)
    company_date = ActiveSupport::TimeZone[company.timezone].parse(date.to_s)
    case company.date_format
    when 1
      company_date.strftime('%Y-%m-%d')
    when 2
      company_date.strftime('%d-%m-%Y')
    when 3
      company_date.strftime('%b-%-d-%Y')
    end
  end

  def route_includes_admin_path
    controller_path.include? 'admin'
  end
end
