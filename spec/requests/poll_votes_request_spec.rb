require 'rails_helper'

describe 'PollVotes' do
  let(:poll) { create(:poll) }
  let(:params) { { company: poll.company.slug, slug: poll.slug } }

  describe '#new' do
    subject do
      get new_poll_vote_url(params)
      response
    end

    it { is_expected.to have_http_status :success }
  end

  describe '#create' do
    let(:result) { 20 }
    let(:params) do
      {
        company: poll.company.slug,
        slug: poll.slug,
        result: result,
        description: 'Spirit Adrift'
      }
    end

    subject do
      post poll_votes_url(params)
      response
    end

    it { is_expected.to have_http_status :success }

    it { expect{ subject }.to change { PollVote.count }.by(1) }

    context 'when there is no result' do
      let(:result) {}

      it { is_expected.to have_http_status :no_content }

      it { expect{ subject }.to change { PollVote.count }.by(0) }
    end
  end
end
