module Admin
  class TrendsController < AdminController
    def global
      @trends = trends_for_period
    end

    private

    def show_weekly?
      params[:period].to_s == 'weekly'
    end

    def trends_for_period
      show_weekly? ? Votes::Trends.weekly(current_company) : Votes::Trends.monthly(current_company)
    end
  end
end
