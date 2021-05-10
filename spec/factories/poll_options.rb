# frozen_string_literal: true

FactoryBot.define do
  factory :poll_option do
    poll
    title { Faker::Marketing.buzzwords }
    value { [10, 20, 30].sample }

    trait :good do
      value { 30 }
    end

    trait :fine do
      value { 20 }
    end

    trait :bad do
      value { 10 }
    end
  end
end
