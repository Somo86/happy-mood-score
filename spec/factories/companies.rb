# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    email { Faker::Internet.email }
    language

    trait :with_slack do
      slack_token { 'Soilwork' }
      slack_team_id { 'Arch Enemy' }
    end
  end
end
