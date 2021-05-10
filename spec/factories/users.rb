# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "email#{n}@test.com"
    end

    password { '111111111' }
    password_confirmation { '111111111' }

    after(:create) do |user|
      user.activate!
    end
  end
end
