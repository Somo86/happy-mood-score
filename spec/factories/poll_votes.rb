# frozen_string_literal: true

FactoryBot.define do
  factory :poll_vote do
    poll
    comment { Faker::Movies::PrincessBride.character }
    result { [10, 20, 30].sample }
  end
end
