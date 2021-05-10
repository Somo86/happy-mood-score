# frozen_string_literal: true

require 'rails_helper'

shared_examples_for 'uuidable' do
  it { is_expected.to validate_presence_of :uuid }
end
