module Api
  module V3
    class FeedbackController < ApiController
      before_action :find_vote, only: %i[create]

      # TODO  move to initializer to reuse it.
      FEEDBACK_RESULTS = {
        'bad' => 10,
        'fine' => 20,
        'good' => 30
      }

      def index
        @feedbacks = Feedback::Finder.new(current_employee, feedback_params).all.page(params[:page]).per(100)
      end

      def create
        if @feedback.update(result: feedback_result, description: params[:message])
          render partial: 'api/v3/feedback/feedback', locals: { feedback: @feedback }
        else
          render json: @feedback.errors
        end
      end

      private

      def employee
        return current_employee unless current_employee.manager?

        current_company.employees.find_by!(uuid: params[:employee_id]) if params[:employee_id].present?
      end

      def find_vote
        @feedback = current_company.votes.votable.find_by!(token: params[:token])
      end

      def feedback_params
        {
          all: 1,
          team_id: team&.id,
          employee_id: employee&.id,
          start_date: params[:start_date].to_s,
          end_date: params[:end_date].to_s
        }
      end

      def feedback_result
        FEEDBACK_RESULTS[params[:status]]
      end

      def team
        return unless current_employee.manager? && params[:team_id].present?

        current_company.teams.find_by!(uuid: params[:team_id])
      end

      def validate_manager
        raise User::Unauthorised unless current_employee.manager?
      end
    end
  end
end
