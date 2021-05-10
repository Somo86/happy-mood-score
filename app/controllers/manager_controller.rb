class ManagerController < UserController
  before_action :require_manager

  protected

  def require_manager
    redirect_to main_dashboard_index_url unless current_user.admin?
  end
end
