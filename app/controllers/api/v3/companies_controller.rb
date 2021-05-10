module Api
  module V3
    class CompaniesController < ApiManagerController
      def show
        @company = current_company
      end
    end
  end
end
