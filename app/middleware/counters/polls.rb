# frozen_string_literal: true

module Counters
  class Polls
    class << self
      def new_vote(vote)
        Poll.increment_counter(:votes, poll_id)
      end
    end
  end
end
