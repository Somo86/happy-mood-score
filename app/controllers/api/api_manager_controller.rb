module Api
  class ApiManagerController < ApiController
    before_action :validate_manager

    private

    def validate_manager
      raise User::Unauthorised unless current_employee.manager?
    end
  end
end
