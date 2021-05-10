module Admin
  class SlackController < AdminController
    before_action :find_company

    def show; end

    def update
    end

    def destroy
      @company.update!(slack_token: nil, slack_team_id: nil)

      redirect_to admin_company_slack_url(@company), notice: I18n.t('companySlackIntegration.tokenRemoved')
    end

    private

    def find_company
      @company = current_company
    end
  end
end
