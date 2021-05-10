module Admin
  class PermissionsController < ::AdminController
    before_action :find_employee, only: %i[update destroy]
    before_action :valid_employee

    def update
      @employee.update(role: :manager)
      @employees = current_company.employees.active.order(role: :desc, name: :asc)

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update('employees-list', partial: "admin/employees/employee", collection: @employees)
        end

        format.html { redirect_to admin_employees_url }
      end
    end

    def destroy
      @employee.update(role: :employee)

      @employees = current_company.employees.active.order(role: :desc, name: :asc)

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update('employees-list', partial: "admin/employees/employee", collection: @employees)
        end

        format.html { redirect_to admin_employees_url }
      end
    end

    private

    def find_employee
      @employee = current_company.employees.find(params[:employee_id])
    end

    def valid_employee
      redirect_to admin_employees_url and return false if @employee.administration?
    end
  end
end
