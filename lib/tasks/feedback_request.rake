namespace :feedback_request do
  desc "Request feedback"
  task create: :environment do
    Companies::Feedback.request
  end
end
