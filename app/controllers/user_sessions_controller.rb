class UserSessionsController < PublicController
  def new
    @invalid_credentials = false
  end

  def create
    @session = login(user_params[:email], user_params[:password])

    if @session
      redirect_back_or_to(admin_dashboard_index_url, notice: I18n.t('dashboardOnboardAdmin.welcome'))
    else
      @invalid_credentials = true

      render 'new'
    end
  end

  def destroy
    logout

    redirect_to(root_url, notice: I18n.t('dashboardOnboardAdmin.bye'))
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
