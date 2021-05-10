module Main
  class RankingController < ::UserController
    def show
      @trends = Ranking::Trends.generate(current_employee)
      @employee = current_employee
    end
  end
end

