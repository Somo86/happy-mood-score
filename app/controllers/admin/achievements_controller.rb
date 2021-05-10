module Admin
  class AchievementsController < AdminController
    def index
      @achievements = Achievement.order(:receiver_id, created_at: :desc).page(params[:page])
    end
  end
end
