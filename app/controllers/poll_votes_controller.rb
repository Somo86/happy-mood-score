class PollVotesController < PublicController
  before_action :find_poll

  def new; end

  def create
    vote = @poll.poll_votes.create(vote_params)

    if vote.valid?
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(
            'new_vote',
            partial: 'poll_votes/thanks'
          )
        end
        format.html { render partial: 'poll_votes/thanks' }
      end
    end
  end

  private

  def vote_params
    params.permit(%i[comment result])
  end

  def find_poll
    company = Company.find_by(slug: params[:company])
    @poll = company.polls.find_by(slug: params[:slug])
  end
end
