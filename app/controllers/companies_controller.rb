class CompaniesController < PublicController
  def new
    @company = Company.new
  end

  def create
    @company = Company.create(company_params)

    if @company.persisted?
      render partial: 'created'
    else
      render 'new'
    end
  end

  private

  def company_params
    params.require(:company).permit(%i[name email language_id])
  end
end
