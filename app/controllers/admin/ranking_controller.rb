module Admin
  class RankingController < ::AdminController
    def teams
      @hms = current_company.teams.with_employees.order(hms: sort_order)
      @involvement = current_company.teams.with_employees.order(involvement: sort_order)
      @table_header = teams_header
    end

    def employees
      @hms = current_company.employees.active.order(hms: sort_order)
      @involvement = current_company.employees.active.order(involvement: sort_order)
      @table_header = employees_header
    end

    private

    def ascending_order?
      params[:order].to_s == 'asc'
    end

    def sort_order
      ascending_order? ? 'asc' : 'desc'
    end

    def teams_header
      {
        order_link: ascending_order? ? I18n.t('dashboardTeams.highRanked') : I18n.t('dashboardTeams.lowRanked'),
        hms: ascending_order? ? I18n.t('dashboardTeams.lowestHms') : I18n.t('dashboardTeams.highestHms'),
        inv: ascending_order? ? I18n.t('dashboardTeams.lowestInvolvement') : I18n.t('dashboardTeams.highestInvolvement')
      }
    end

    def employees_header
      {
        order_link: ascending_order? ? I18n.t('dashboardPeople.highRanked') : I18n.t('dashboardPeople.lowRanked'),
        hms: ascending_order? ? I18n.t('dashboardPeople.lowestHms') : I18n.t('dashboardPeople.highestHms'),
        inv: ascending_order? ? I18n.t('dashboardPeople.lowestInvolvement') : I18n.t('dashboardPeople.highestInvolvement')
      }
    end
  end
end

