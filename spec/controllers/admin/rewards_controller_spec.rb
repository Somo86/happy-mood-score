# frozen_string_literal: true

require 'rails_helper'

describe Admin::RewardsController do
  let(:name) { 'Toundra' }
  let(:category) { :badge }
  let(:params) do
    {
      reward: {
        name: name,
        category: category
      }
    }
  end
  let(:admin) { create(:employee, :admin) }
  let(:company) { admin.company }

  before { login_user admin.user }

  describe '#show' do
    let(:reward) { create(:reward, company: company) }

    subject { get :show, params: { id: reward.id } }

    it { is_expected.to have_http_status :success }
  end

  describe '#new' do
    subject { get :new }

    it { is_expected.to have_http_status :success }
  end

  describe '#create' do
    subject { post :create, params: params }

    it { is_expected.to have_http_status :redirect }

    it { expect { subject }.to change { Reward.count }.by(1) }

    context 'new reward' do
      let(:new_reward) { Reward.find_by(name: name) }

      before { subject }

      it { expect(new_reward.name).to eql name }
      it { expect(new_reward.category).to eql 'badge' }
    end
  end

  describe '#edit' do
    let(:reward) { create(:reward, company: company) }
    let(:params) { { id: reward.id } }

    subject { get :new, params: params }

    it { is_expected.to have_http_status :success }
  end

  describe '#update' do
    let(:reward) { create(:reward, company: company) }
    let(:name) { 'Mono Inc.' }
    let(:params) { { id: reward.id, reward: { name: name } } }

    subject { put :update, params: params }

    it { is_expected.to have_http_status :redirect }

    context 'updated reward' do
      let(:updated_reward) { Reward.find_by(name: name) }

      before { subject }

      it { expect(updated_reward.name).to eql name }
    end
  end

  describe '#destroy' do
    let!(:reward) { create(:reward, company: company) }
    let(:params) { { id: reward.id } }

    subject { delete :destroy, params: params }

    it { is_expected.to have_http_status :redirect }

    it { expect { subject }.to change { Reward.count }.by(-1) }
  end
end
