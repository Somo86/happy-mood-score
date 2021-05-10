module Admin
  class TestEmailsController < AdminController
    def feedback_request
      FeedbackMailer.with(current_user, 'test-email').request_email.deliver_later
      @delivered = true

      render partial: 'admin/deliveries/test_email'
    end
  end
end
