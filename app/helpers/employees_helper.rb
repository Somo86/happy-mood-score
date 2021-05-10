# frozen_string_literal: true

module EmployeesHelper
  def employee_avatar_link(employee)
    if employee.avatar.attached?
      url_for(employee.avatar)
    else
      image_url 'default_avatar.svg'
    end
  end

  def employee_avatar(employee, size="md")
    if employee.present? && employee.avatar.attached?
      image_tag employee.avatar.variant(resize_to_limit: [250, 250]), alt: employee.name, class: 'rounded-full ' + image_size(size)
    else
      file_path = "#{Rails.root}/app/assets/images/default_avatar.svg"
      content_tag(:div,
                  content_tag(
                    :span,
                    File.read(file_path).html_safe,
                    class: image_size(size) + ' rounded-full overflow-hidden bg-gray-100'
                  ),
                  class: 'flex items-center'
                 )
    end
  end

  def image_size(size)
    case size
    when 'sm'
      'h-8 w-8'
    when 'lg'
      'h-16 w-16'
    else
      'h-12 w-12'
    end
  end
end
