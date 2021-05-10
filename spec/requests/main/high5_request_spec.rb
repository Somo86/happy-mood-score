# frozen_string_literal: true

require 'rails_helper'

describe 'Main::High5' do
  let(:employee) { create(:employee) }
  let(:company) { employee.company }
  let(:receiver) { create(:employee, company: company) }

  before { login_user_request employee.user }

  describe '#index' do
    subject do
      get main_high5_index_url
      response
    end

    it { is_expected.to have_http_status :success }
    it { is_expected.to render_template :index }
  end

  describe '#new' do
    subject do
      get new_main_high5_url, params: { receiver_id: receiver.id }
      response
    end

    it { is_expected.to have_http_status :success }
    it { is_expected.to render_template :new }
  end

  describe '#create' do
    let(:params) { { } }

    subject do
      post main_high5_index_url, params: params
      response
    end

    context 'with valid params' do
      let(:params) { { receiver_id: receiver.id } }

      it { is_expected.to have_http_status :success }
      it { is_expected.to render_template :new }

      context 'new high 5' do
        let(:params) { { receiver_id: receiver.id, description: 'Scar symmetry' } }
        let(:high5) { company.events.high5.first }

        before { post main_high5_index_url, params: params }

        subject { receiver.activities.first }

        its(:description) { is_expected.to eql 'Scar symmetry' }
        its(:sender_id) { is_expected.to eql employee.id  }
        its(:event) { is_expected.to eql high5 }
      end
    end
  end
end
