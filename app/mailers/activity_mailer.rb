# frozen_string_literal: true

class ActivityMailer < ApplicationMailer
  def new_high5(high5)
    user = high5.employee.user
    @company = high5.employee.company
    @employee = high5.employee

    mail to: user.email, subject: I18n.t('server.hi5EmployeeEmail.subject', company_name: @company.name)
  end
end
