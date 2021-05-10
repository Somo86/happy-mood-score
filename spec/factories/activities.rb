# frozen_string_literal: true

FactoryBot.define do
  factory :activity do
    employee
    event

    trait :high5 do
      sender { association :employee, company: employee.company }
      event { association :event, category: 1 }
    end
  end
end
