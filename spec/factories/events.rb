# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    company
    name { Faker::Marketing.buzzwords }
    description { Faker::Beer.style }
    value { Faker::Number.number(digits: 2) }

    trait :high5 do
      category { 1 }
    end

    trait :feedback do
      category { 2 }
    end

    trait :vote do
      category { 3 }
    end
  end
end
