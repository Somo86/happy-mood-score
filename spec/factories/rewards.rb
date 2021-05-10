# frozen_string_literal: true

FactoryBot.define do
  factory :reward do
    company
    name { Faker::Beer.name }
    active { true }
    category { %i[badge level].sample }
    description { Faker::Beer.style }

    trait :badge do
      category { :badge }
    end

    trait :level do
      category { :level }
    end
  end
end
