# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::Dashboard', type: :request do
  let(:company) { create(:company) }
  let(:employee) { company.employees.first }

  describe '#index' do
    before { login_user_request employee.user }

    subject do
      get admin_dashboard_index_url
      response
    end

    context 'when request is valid' do
      it { is_expected.to have_http_status :success }

      it { is_expected.to render_template :index }
    end

    context 'when user is not an admin' do
      let(:employee) { create(:employee, company: company) }

      it { is_expected.to have_http_status :redirect }
    end
  end
end
