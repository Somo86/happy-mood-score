FactoryBot.define do
  factory :team do
    sequence :name do |n|
      "#{Faker::Science.element} #{n}"
    end
    company
  end
end
