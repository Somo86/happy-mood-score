module Api
  class SlackController < ApplicationController
    def auth
      if Slack::Account.authorise(auth_params)
        redirect_to admin_company_slack_url(auth_params[:state])
      else
        head :unauthorized
      end
    end

    def feedback
      # Rails also uses action
      params[:action] = request.request_parameters['action']

      render plain: Slack::Vote.create(params)
    end

    def high5
      render plain: Slack::High5.create(params)
    end

    def one2one
      render plain: Slack::Note.create(params)
    end

    def report
      render plain: Slack::Report.create(params)
    end

    private

    def auth_params
      params.permit(%i[state code])
    end

    def response_params
      params.permit(:payload)
    end
  end
end
