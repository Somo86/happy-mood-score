# frozen_string_literal: true

module VotesHelper
  def vote_weight(entity, vote_type)
    total_votes = entity.results_good + entity.results_fine + entity.results_bad
    return 0 if total_votes.zero?

    case vote_type
    when 'good'
      (entity.results_good * 100) / total_votes
    when 'fine'
      (entity.results_fine * 100) / total_votes
    when 'bad'
      (entity.results_bad * 100) / total_votes
    else
      0
    end
  end

  def result_to_colour(result)
    case result
    when 10
      'bg-red-100 text-red-800'
    when 20
      'bg-blue-100 text-blue-800'
    when 30
      'bg-green-100 text-green-800'
    else
      'bg-yellow-100 text-yellow-800'
    end
  end

  def result_to_text(result)
    case result
    when 10
      I18n.t('leftDashboard.bad')
    when 20
      I18n.t('leftDashboard.fine')
    when 30
      I18n.t('leftDashboard.happy')
    end
  end
end

