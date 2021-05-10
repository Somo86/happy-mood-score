# frozen_string_literal: true

RSpec.shared_examples 'employee not manager' do
  let(:employee) { create(:employee) }

  it { is_expected.to have_http_status :unauthorized }
end
