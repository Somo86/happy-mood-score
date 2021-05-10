module Admin
  class DeliveriesController < ::AdminController
    before_action :find_company

    def index
      @any_employees = @company.employees.active.any?
    end

    def update
      @company.update(company_params)

      if @company.valid?
        redirect_to admin_company_url(@company), notice: I18n.t('autoForm.companyUpdated')
      else
        render 'edit'
      end
    end

    private

    def company_params
      params.permit(%i[])
    end

    def find_company
      @company = current_company
    end
  end
end
