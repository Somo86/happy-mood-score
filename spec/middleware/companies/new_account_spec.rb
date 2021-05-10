# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Companies::NewAccount do
  let(:company) { create(:company, name: 'Brand new') }

  describe '#generate' do
    before { company }

    context 'team' do
      subject { company.teams.first }

      its(:name) { is_expected.to eql 'Team Brand new' }
      its(:employees_count) { is_expected.to eql 1 }
    end

    context 'user' do
      subject { User.find_by(email: company.email) }

      its(:activation_state) { is_expected.to eql 'pending' }
    end

    context 'employee' do
      subject { company.employees.first }

      its(:name) { is_expected.to eql 'Administrator' }
      its(:role) { is_expected.to eql 'admin' }
    end
  end
end
