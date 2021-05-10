module Main
  class FeedbackController < UserController
    def index
      @feedback = current_employee.votes.order(:updated_at)
    end
  end
end

