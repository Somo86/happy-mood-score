module Slack
  module Verified
    def company
      @company ||= Company.find_by(slack_team_id: team_id)
    end

    def valid_request?
      valid_token? && company.present?
    end

    def valid_token?
      token == Rails.application.credentials.dig(:slack, :verification_token)
    end
  end
end
