module Main
  class DashboardController < UserController
    def index
      @dashboard = Dashboards::Main.generate(current_employee)
      @employee = current_employee
      @has_votes = current_employee.votes.any?
    end
  end
end
