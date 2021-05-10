module Main
  class EmployeesController < UserController
    before_action :find_employee

    def edit; end

    def update
      if @employee.update(employee_params)
        redirect_to main_dashboard_index_url, notice: I18n.t('autoForm.employeeUpdated')
      else
        render 'edit'
      end
    end

    private

    def employee_params
      params.require(:employee).permit(%i[language_id avatar name slack_username])
    end

    def find_employee
      @employee = current_employee
    end
  end
end
