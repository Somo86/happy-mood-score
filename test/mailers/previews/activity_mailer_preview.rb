# frozen_string_literal: true

class ActivityMailerPreview < ActionMailer::Preview
  def new_high5
    high5 = Event.high5.first
    activity = Activity.where(event_id: high5.id).first

    ActivityMailer.new_high5(activity)
  end
end
