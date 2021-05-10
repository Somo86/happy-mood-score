# frozen_string_literal: true

Language.destroy_all
Company.destroy_all
User.destroy_all
Team.destroy_all
Employee.destroy_all
Event.destroy_all
Rule.destroy_all
Reward.destroy_all
Poll.destroy_all

language = Language.create!(name: 'English', code: 'en')
Language.create!(name: 'Español', code: 'es')

company = Company.create!(name: 'Party time', email: 'admin@test.com', language: language)
company.teams.create!(name: Faker::Book.title)
User.first.update(password: '111111111', password_confirmation: '111111111')
User.first.activate!

manager = company.employees.create!(name: 'Mille Petrozza', email: 'user@test.com', language: company.language, team: company.teams.first, role: :manager)
manager.user.update(password: '111111111', password_confirmation: '111111111')
manager.user.activate!

13.times do
  employee = company.employees.create!(name: Faker::DcComics.name, email: Faker::Internet.email, language: Language.all.sample, team: company.teams.sample)
  employee.votes.create!
end

48.times do
  employee = Employee.all.sample
  vote = employee.votes.create!
  if rand(10) > 2
    vote.update(result: [10, 20, 30].sample, description: Faker::GreekPhilosophers.quote)
  end

  if rand(10) > 5
    Reply.create!(vote: vote, employee: manager, description: Faker::Marketing.buzzwords)
  end

  if rand(10) > 3
    receiver = Employee.all.sample
    Activities::High5.create(employee, receiver, Faker::GreekPhilosophers.quote)
  end
end

poll = company.polls.create!(name: 'My amazing first pool', title: 'Are things really amazing?', description: 'Tell me now')

5.times do
  poll.poll_votes.create! result: [10, 20, 30].sample, comment: [Faker::Movies::PrincessBride.quote, nil].sample
end
