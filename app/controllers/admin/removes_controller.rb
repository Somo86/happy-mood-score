module Admin
  class RemovesController < ::AdminController
    before_action :find_company

    def index; end

    private

    def find_company
      @company = current_user.company
    end
  end
end
