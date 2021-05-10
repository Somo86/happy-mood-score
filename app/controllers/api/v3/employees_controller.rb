module Api
  module V3
    class EmployeesController < ApiController
      before_action :user_is_manager
      before_action :validate_manager, except: %i[index show]
      before_action :find_employee, except: %i[index create]

      def index
        @employees = current_company.employees.page(params[:page]).per(100)
      end

      def show; end

      def create
        @employee = current_company.employees.create(employee_params.merge(language: current_company.language, team_id: team_id))

        if @employee.persisted?
          render partial: 'api/v3/employees/employee', locals: { employee: @employee }
        else
          render json: @employee.errors
        end
      end

      def update
        if @employee.update(employee_params.merge(team_id: team_id))
          render partial: 'api/v3/employees/employee', locals: { employee: @employee }
        else
          render json: @employee.errors
        end
      end

      private

      def employee_params
        params.permit(%i[name email team_id push_key])
      end

      def find_employee
        @employee = current_company.employees.find_by(uuid: params[:id])
      end

      def team_id
        uuid = params[:team_id] || @employee&.team&.uuid

        current_company.teams.find_by(uuid: uuid)&.id
      end

      def user_is_manager
        @is_manager = current_employee.manager?
      end

      def validate_manager
        raise User::Unauthorised unless current_employee.manager?
      end
    end
  end
end
