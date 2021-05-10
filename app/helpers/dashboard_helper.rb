module DashboardHelper
  def alert_color(type)
    case type
    when 'success'
      'green'
    when 'warning'
      'yellow'
    when 'danger'
      'red'
    else
      'blue'
    end
  end

  def trend_color(value)
    return 'green' if value.positive?
    return 'red' if value.negative?

    'indigo'
  end
end
