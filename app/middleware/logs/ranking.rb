# frozen_string_literal: true

module Logs
  class Ranking
    class << self
      def update_team(team, date)
        new(team, date).update
      end

      def update_company(company, date)
        new(company, date).update
      end
    end

    def initialize(entity, date)
      @entity = entity
      @date = date
    end

    def update
      position = 1
      active_employees.each do |employee|
        log = employee.historical_logs.find_by(generated_on: date)
        log.update("#{entity_name}_ranking" => position)
        position += 1
      end
      update_entity_log
    end

    private

    attr_reader :entity, :date

    def active_employees
      @active_employees ||= entity.employees.active.order(involvement: :desc)
    end

    def entity_name
      entity.class.to_s.downcase
    end

    def update_entity_log
      log = entity.historical_logs.find_by(generated_on: date)
      log.update(active_employees: active_employees.size)
    end
  end
end
