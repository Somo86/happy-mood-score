# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  subject { build(:event) }

  it_behaves_like 'uuidable'

  it { is_expected.to belong_to :company }
  it { is_expected.to have_many :activities }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:company_id).case_insensitive }
  it { is_expected.to validate_presence_of(:value) }
  it { is_expected.to validate_numericality_of(:value) }
  it { is_expected.to define_enum_for(:category).with_values({ generic: 0, high5: 1, feedback: 2, vote: 3, idea: 4, idea_vote: 5, idea_comment: 6 }) }
end
