# frozen_string_literal: true

RSpec.shared_examples 'invalid token' do
  let(:token) { 'invalid' }

  it { is_expected.to have_http_status :not_found }
end
