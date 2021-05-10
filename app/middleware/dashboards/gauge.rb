# frozen_string_literal: true

module Dashboards
  class Gauge
    def initialize(entity, options={})
      @entity = entity
      @hms_id = options.fetch(:hms_id, 'hms')
      @inv_id = options.fetch(:involvement_id, 'inv')
    end

    def generate
      {
        hms: hms_gauge,
        involvement: involvement_gauge
      }
    end

    private

    attr_reader :entity, :hms_id, :inv_id

    def hms_gauge
      {
        id: hms_id,
        title: 'Happy Mood Score',
        needle: hms_as_percentage,
        labels: [I18n.t('hmsTrends.bad'), I18n.t('hmsTrends.fine'), I18n.t('hmsTrends.happy')],
        data: [25, 50, 25],
        colour: ["#fa5e5b", "#ffc83f", "#16c98d"],
      }
    end

    def involvement_gauge
      {
        id: inv_id,
        title: I18n.t('leftDashboard.involvement'),
        needle: involvement_as_percentage,
        labels: [I18n.t('userTrends.low'), I18n.t('userTrends.normal'), I18n.t('userTrends.excellent')],
        data: [60, 25, 15],
        colour: ["#fa5e5b", "#ffc83f", "#16c98d"]
      }
    end

    def hms_as_percentage
      hms_percentage = ((entity.hms.to_f - -10) / (10 - -10).to_f * 100).round

      (Math::PI * ((hms_percentage - 100) * -1) / 100) * -1
    end

    def involvement_as_percentage
      (Math::PI * ((entity.involvement - 100) * -1) / 100) * -1
    end
  end
end
