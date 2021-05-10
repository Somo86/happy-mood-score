# frozen_string_literal: true

module Activities
  class High5
    class << self
      def create(sender, receiver, description)
        high5 = receiver.activities.create(
          description: description,
          sender_id: sender&.id,
          event: high5_event(sender)
        )
        update_counters(sender, receiver) if high5.persisted?

        high5
      end

      def high5_event(sender)
        sender.company.events.high5.first
      end

      private

      def update_counters(sender, receiver)
        Counters::Update.new_high5(sender, receiver)
      end
    end
  end
end
