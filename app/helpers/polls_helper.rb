# frozen_string_literal: true

module PollsHelper
  def bg_active(active)
    active ? 'bg-indigo-600' : 'bg-gray-200'
  end

  def tr_active(active)
    active ? 'translate-x-5' : 'translate-x-0'
  end
end
