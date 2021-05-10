# frozen_string_literal: true

module FeedbackHelper
  def feedback_result(result)
    content_tag(:span, result_to_text(result), class: "ml-4 px-2 inline-flex text-xs leading-5 font-semibold rounded-full #{result_to_colour(result)}")
  end
end
