module Admin
  class DashboardController < ManagerController
    def index
      @dashboard = Dashboards::Admin.generate(current_company)
      @company = current_company
      @any_votes = current_company.votes.voted.any?
    end
  end
end
