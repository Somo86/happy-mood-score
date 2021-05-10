# frozen_string_literal: true

module Companies
  class NewAccount
    class << self
      def setup!(company)
        team = company.teams.create!(name: "Team #{company.name}")
        company.employees.create!(
          name: 'Administrator',
          email: company.email,
          team: team,
          language: company.language,
          role: 2,
          level_name: 'Level 0'
        )
        Companies::Gamification.setup!(company)
      end
    end
  end
end
