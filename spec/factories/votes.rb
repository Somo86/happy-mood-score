# frozen_string_literal: true

FactoryBot.define do
  factory :vote do
    company
    team { association :team, company: company }
    employee { association :employee, team: team, company: company }

    trait :voted do
      result { [10, 20, 30].sample }
      token { nil }

      after(:create) do |vote|
        vote.update(token: nil)
      end
    end

    trait :old do
      voted
      recent { false }
    end
  end
end
