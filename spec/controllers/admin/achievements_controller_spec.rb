# frozen_string_literal: true

require 'rails_helper'

describe Admin::AchievementsController do
  let(:admin) { create(:employee, :admin) }

  before { login_user admin.user }

  describe '#index' do
    subject { get :index }

    it { is_expected.to have_http_status :success }
  end
end
