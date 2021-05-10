class UserController < ApplicationController
  before_action :require_login

  private

  def current_company
    current_user.company
  end

  def current_employee
    current_user.employee
  end
end
