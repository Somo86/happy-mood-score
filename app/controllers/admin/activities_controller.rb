module Admin
  class ActivitiesController < AdminController
    def index
      @activities = Activity.order(created_at: :desc).page(params[:page])
    end
  end
end
