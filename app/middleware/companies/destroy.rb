# frozen_string_literal: true

module Companies
  class Destroy
    class << self
      def all(company_id)
        company = Company.find(company_id)
        company.rewards.destroy_all
        company.events.destroy_all
        User.where(id: company.employees.pluck(:user_id)).destroy_all
        company.employees.destroy_all
        company.teams.destroy_all
        company.remove
      end
    end
  end
end
