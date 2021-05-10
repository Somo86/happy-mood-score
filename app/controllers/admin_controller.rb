class AdminController < UserController
  before_action :require_admin

  private

  def require_admin
    redirect_to main_dashboard_index_url unless current_user.admin?
  end
end
