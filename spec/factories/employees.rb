# frozen_string_literal: true

FactoryBot.define do
  factory :employee, aliases: [:creator, :sender] do
    company
    language { company.language }
    team { association :team, company: company }
    name { Faker::DcComics.name }
    sequence :email do |n|
      "email#{n}@test.com"
    end


    trait :admin do
      role { :admin }
    end

    trait :manager do
      role { :manager }
    end

    trait :archived do
      deleted_at { 3.days.ago }
    end
  end
end
