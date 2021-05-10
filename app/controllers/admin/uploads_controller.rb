module Admin
  class UploadsController < AdminController
    before_action :validate_file, only: [:create]

    def new
    end

    def create
      @results = Employees::Upload.new(params[:employees], current_employee).import
      if @results.size.zero?
        redirect_to admin_employees_url, notice: I18n.t("employeesCsv.success")
      else
        render 'new'
      end
    end

    protected

    def validate_file
      redirect_to new_admin_upload_url and return if params[:employees].blank?
    end
  end
end
