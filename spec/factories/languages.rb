# frozen_string_literal: true

FactoryBot.define do
  factory :language do
    name { Faker::ProgrammingLanguage.name[0..45] }
    code { 'en' }

    factory :spanish do
      name { 'Español' }
      code { 'es' }
    end
  end
end
