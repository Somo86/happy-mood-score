module Admin
  class EmployeesController < ::AdminController
    before_action :find_employee, only: %i[edit update destroy]

    def index
      @show_archived = params[:archived].to_i != 1
      @employees = employees_list
    end

    def new
      @employee = current_company.employees.new
    end

    def create
      @employee = current_company.employees.create(employee_params)

      if @employee.valid?
        redirect_to admin_employees_url, notice: I18n.t("autoForm.employeeCreated")
      else
        render 'new'
      end
    end

    def edit; end

    def update
      @employee.update(employee_params)
      if @employee.valid?

        redirect_to admin_employees_url, notice: I18n.t("autoForm.employeeUpdated")
      else
        render 'edit'
      end
    end

    def search
      @employees = employees_list

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update('employees-list', partial: 'admin/employees/employee', collection: @employees)
        end

        format.html { redirect_to admin_employees_url }
      end
    end

    private

    def employee_params
      params.require(:employee).permit(:name, :team_id, :language_id, :avatar, :slack_username, :email)
    end

    def employees_list
      Employees::Finder.new(current_company, params).all
    end

    def find_employee
      @employee = current_company.employees.find(params[:id])
    end
  end
end
