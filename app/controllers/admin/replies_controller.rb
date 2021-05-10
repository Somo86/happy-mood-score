module Admin
  class RepliesController < ::AdminController
    before_action :find_vote

    def create
      @vote.replies.create!(description: params[:description], employee: current_employee)

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(
            "vote_#{@vote.id}",
            partial: 'admin/feedback/feedback', locals: { feedback: @vote }
          )
        end
        format.html { redirect_to admin_feedback_index_url, notice: I18n.t('feedbackList.sentOk') }
      end
    end

    private

    def find_vote
      @vote = current_company.votes.voted.find(params[:feedback_id])
    end
  end
end
