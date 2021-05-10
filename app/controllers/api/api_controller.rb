module Api
  class User::Unauthorised < StandardError; end

  class ApiController < ApplicationController
    attr_reader :current_employee

    skip_before_action :verify_authenticity_token
    before_action :login_from_token

    layout :false

    rescue_from User::Unauthorised do
      render json: '', status: :unauthorized
    end

    rescue_from ActiveRecord::RecordNotFound do
      render json: '', status: :not_found
    end

    private

    def login_from_token
      authenticate_with_http_token do |token|
        @current_employee = Employee.find_by!(api_key: token)
      end
    end

    def current_company
      current_employee.company
    end
  end
end
