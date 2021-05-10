module Admin
  class FeedbackController < AdminController
    before_action :set_session
    before_action :find_teams

    def index
      @any_feedback = current_employee.company.votes.any?
      @feedback = feedback.page(params[:page].to_i).order(:updated_at)
      @filter = session[:feedback]
    end

    def update
      feedback.update_all(recent: false)

      redirect_to admin_feedback_index_url
    end

    private

    def feedback_params
      { new: params[:new].to_i, team_id: params[:team_id], employee_id: params[:employee_id] }
    end

    def set_session
      if session[:feedback].present?
        current_params = session[:feedback].symbolize_keys
        current_params.merge!(feedback_params) { |key, left_value, right_value| right_value.present? ? right_value : left_value }
        session[:feedback] = current_params
      else
        session[:feedback] = feedback_params
      end
    end

    def feedback
      Feedback::Finder.new(current_employee, feedback_params).all
    end

    def find_teams
      @teams = current_company.teams.order(:name)
    end
  end
end
