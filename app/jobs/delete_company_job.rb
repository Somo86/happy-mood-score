# frozen_string_literal: true

class DeleteCompanyJob < ApplicationJob
  queue_as :default

  def perform(company_id)
    Companies::Destroy.all(company_id)
  end
end
