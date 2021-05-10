# frozen_string_literal: true

module Slack
  module Received
    def employee
      @employee ||= company.employees.active.with_username(user_name).first
    end

    def find_receiver(slack_user_name)
      company.employees.active.with_username(slack_user_name).first
    end

    def receivers
      text.scan(/@([a-zA-Z0-9._-]*)/).flatten
    end

    def valid_content?
      valid_request? && employee.present? && receivers.any?
    end
  end
end


