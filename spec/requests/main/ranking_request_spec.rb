# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Main::Ranking', type: :request do
  let(:company) { create(:company) }
  let(:employee) { create(:employee, :manager, company: company) }

  describe '#index' do
    before { login_user_request employee.user }

    subject do
      get main_ranking_url(employee)
      response
    end

    context 'when request is valid' do
      it { is_expected.to have_http_status :success }

      it { is_expected.to render_template :show }
    end
  end
end
