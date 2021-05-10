# frozen_string_literal: true

FactoryBot.define do
  factory :note do
    employee
    receiver { association :employee, company: employee.company, team: employee.team }
    description { Faker::Movies::PrincessBride.quote }

    trait :closed do
      done { true }
    end
  end
end
