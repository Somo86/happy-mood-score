module Admin
  class CompaniesController < ::AdminController
    before_action :find_company

    def show; end

    def edit; end

    def update
      @company.update(company_params)

      if @company.valid?
        redirect_to admin_company_url(@company), notice: I18n.t('autoForm.companyUpdated')
      else
        render 'edit'
      end
    end

    def destroy
      if valid_confirmation_word?
        DeleteCompanyJob.perform_later(@company.id)
        logout

        redirect_to(root_url, notice: I18n.t('user_session.bye'))
      end
    end

    private

    def company_params
      params.require(:company).permit(%i[name vat_number address city country language_id date_format timezone frequency weekday hour confirm])
    end

    def find_company
      @company = current_user.company
    end

    def valid_confirmation_word?
      company_params[:confirm].present? && company_params[:confirm].downcase == 'delete'
    end
  end
end
