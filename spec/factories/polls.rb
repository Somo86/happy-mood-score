# frozen_string_literal: true

FactoryBot.define do
  factory :poll do
    company
    name { Faker::Marketing.buzzwords }
  end
end
