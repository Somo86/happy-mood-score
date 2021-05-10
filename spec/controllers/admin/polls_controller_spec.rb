# frozen_string_literal: true

require 'rails_helper'

describe Admin::PollsController do
  let(:company) { create(:company) }
  let(:poll) { create(:poll, company: company) }
  let(:admin) { create(:employee, :admin, company: company) }

  before { login_user admin.user }

  describe '#index' do
    subject { get :index }

    it { is_expected.to have_http_status :success }
  end

  describe '#new' do
    subject { get :new }

    it { is_expected.to have_http_status :success }
  end

  describe '#show' do
    subject { get :show, params: { id: poll.id } }

    it { is_expected.to have_http_status :success }
  end

  describe '#create' do
    let(:name) { 'A new poll for the world' }
    let(:params) { { name: name  } }
    subject { post :create, params: { poll: params } }

    it { is_expected.to have_http_status :redirect }

    it { expect { subject }.to change { Poll.count }.by(1) }

    context 'new poll' do
      subject { Poll.find_by(name: name) }

      before { post :create, params: { poll: params } }

      its(:name) { is_expected.to eql name }
      its(:company) { is_expected.to eql admin.company }
    end
  end

  describe '#edit' do
    let(:event) { create(:event) }
    let(:params) { { id: event.uuid } }

    subject { get :new, params: params }

    it { is_expected.to have_http_status :success }
  end

  describe '#update' do
    let(:poll) { create(:poll, company: admin.company) }
    let(:title) { 'Mono Inc.' }
    let(:description) { 'Vote me!' }
    let(:active) { true }
    let(:params) { { id: poll.id, poll: { title: title, description: description, active: active } } }

    subject { put :update, params: params }

    it { is_expected.to have_http_status :redirect }

    context 'updated poll' do
      subject { Poll.find_by(title: title) }

      before { put :update, params: params }

      its(:title) { is_expected.to eql title }
      its(:description) { is_expected.to eql description }
      its(:active) { is_expected.to eql active }
    end
  end

  describe '#destroy' do
    let(:active) { false }
    let!(:poll) { create(:poll, company: company, active: active) }
    let(:params) { { id: poll.id } }

    subject { delete :destroy, params: params }

    it { is_expected.to have_http_status :redirect }

    context 'when poll is inactive' do
      it { expect { subject }.to change { Poll.count }.by(-1) }
    end

    context 'when poll is active' do
      let(:active) { true }

      it { expect { subject }.to change { Poll.count }.by(0) }
    end
  end
end
