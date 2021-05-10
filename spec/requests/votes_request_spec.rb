# frozen_string_literal: true

require 'rails_helper'

describe VotesController do
  let(:vote) { create(:vote) }

  describe '#new' do
    let(:status) { 'fine' }

    subject do
      get new_vote_url({ id: vote.token, status: status })
      response
    end

    it { is_expected.to have_http_status :success }

    it { is_expected.to render_template(:new) }

    context 'vote' do
      before { get new_vote_url(id: vote.token, status: status) }

      subject { vote.reload }

      its(:token) { is_expected.to be_blank }

      context 'when vote is good' do
        let(:status) { 'good' }

        its(:result) { is_expected.to eql(30) }
      end

      context 'when vote is fine' do
        its(:result) { is_expected.to eql(20) }
      end

      context 'when vote is fine' do
        let(:status) { 'bad' }

        its(:result) { is_expected.to eql(10) }
      end
    end
  end

  describe '#create' do
    let(:vote) { create(:vote, :voted) }
    let(:token_id) { vote.uuid }
    let(:message) { 'What a week, Hulio!!!' }

    before { vote.save }

    subject { post votes_url, params: { message: message, uuid: token_id }  }

    it { is_expected.to redirect_to(root_url) }

    it { subject; expect(vote.reload.description).to eql message }

    context 'when token is invalid' do
      let(:token_id) { 'invalid' }

      it { is_expected.to redirect_to(root_url) }

      it { expect(vote.reload.description).to be_blank }
    end
  end
end
