# frozen_string_literal: true

require 'rails_helper'

describe 'Main::Notes' do
  let(:employee) { create(:employee) }
  let(:company) { employee.company }

  before { login_user_request employee.user }

  describe '#index' do
    subject do
      get main_notes_url
      response
    end

    it { is_expected.to have_http_status :success }
    it { is_expected.to render_template :index }
  end

  describe '#create' do
    let(:params) { { } }

    subject do
      post main_notes_url, params: params
      response
    end

    context 'with valid params' do
      let(:params) { { note: { description: 'Children of Bodom' } } }

      it { is_expected.to have_http_status :redirect }

      context 'new note' do
        before { post main_notes_url, params: params }

        subject { employee.notes.first }

        its(:description) { is_expected.to eql 'Children of Bodom' }
        its(:done) { is_expected.to be false  }
        its(:receiver_id) { is_expected.to eql employee.id }
      end
    end
  end

  describe '#update' do
    let(:note) { create(:note, employee: employee) }
    before { put main_note_url(note) }

    it { expect(response).to have_http_status :redirect }
    it { expect(note.reload.done).to be true }
  end
end
