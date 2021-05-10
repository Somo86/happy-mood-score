module Admin
  class PollsController < ::AdminController
    before_action :find_poll, only: %i[show edit update destroy toggle]

    def index
      @polls = current_company.polls
    end

    def show; end

    def new
      @poll = current_company.polls.new
    end

    def create
      @poll = current_company.polls.create(create_params)

      if @poll.persisted?
        redirect_to admin_polls_url, notice: I18n.t('pollsIndex.pollCreated')
      else
        render 'new'
      end
    end

    def edit; end

    def update
      if @poll.update(update_params)
         redirect_to admin_polls_url, notice: I18n.t('editContentForm.contentUpdated')
      else
        render 'edit'
      end
    end

    def toggle
      @poll.active.toggle

        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.update(
              "poll_#{@poll.id}",
              partial: 'admin/polls/poll', locals: { poll: @poll }
            )
          end
          format.html { redirect_to admin_polls_url, notice: I18n.t('editContentForm.contentUpdated') }
        end
    end

    def destroy
      notice = I18n.t('pollDelete.success')
      notice = I18n.t('pollDelete.notActive') if !@poll.destroy

      redirect_to admin_polls_url, notice: notice
    end

    private

    def find_poll
      @poll = current_company.polls.find(params[:id])
    end

    def create_params
      params.require(:poll).permit(%i[name])
    end

    def update_params
      params.require(:poll).permit(:title, :description, :active, :show_comments, poll_options_attributes: [:id, :title])
    end
  end
end
