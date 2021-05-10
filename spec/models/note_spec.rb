# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Note, type: :model do
  let(:note) { build(:note) }

  it { is_expected.to belong_to :employee }
  it { is_expected.to belong_to(:receiver).optional }

  it { is_expected.to validate_presence_of(:description) }

  describe 'when creating a new note' do
    subject { note.save; note }

    its(:shared) { is_expected.to be false }
    its(:done) { is_expected.to be false }
  end
end
