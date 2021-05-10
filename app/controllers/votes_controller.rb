# TODO: rename as feedback controller
class VotesController < PublicController
  def new
    @vote = Vote.votable.find_by(token: params[:id])

    if @vote
      set_language
      @uuid = @vote.uuid if @vote.update(result: VOTE_RESULT[params[:status].to_sym])
    else
      redirect_to root_url, notice: I18n.t('votesController.feedbackError')
    end
  end

  def create
    @vote = Vote.voted.find_by(uuid: params[:uuid])
    notice = I18n.t('votesController.feedbackError')
    if @vote && params[:message].present?
      set_language
      notice = I18n.t('votesController.feedbackRecorded') if @vote.update(description: params[:message])

      redirect_to root_url, notice: notice
    else
      redirect_to root_url, notice: I18n.t('votesController.feedbackError')
    end
  end

  private

  def set_language
    I18n.locale = @vote.employee.language.code
  end
end
