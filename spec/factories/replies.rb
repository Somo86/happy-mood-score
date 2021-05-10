# frozen_string_literal: true

FactoryBot.define do
  factory :reply do
    vote
    employee
    description { Faker::Movies::PrincessBride.quote }
  end
end
