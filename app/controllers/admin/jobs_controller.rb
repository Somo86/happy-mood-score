module Admin
  class JobsController < ::AdminController
    before_action :find_company

    def create
      Jobs::Persistence.new(@company).create

      render partial: 'admin/deliveries/action'
    end

    def destroy
      Jobs::Persistence.new(@company).destroy

      render partial: 'admin/deliveries/action'
    end

    private

    def find_company
      @company = current_user.company
    end
  end
end
