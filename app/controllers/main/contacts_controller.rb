module Main
  class ContactsController < UserController
    def new; end

    def create
      if params[:message].present?
        ContactMailer.send_email(current_user, params[:message]).deliver_later

        redirect_to main_dashboard_index_url, notice: I18n.t("contact.messageReceived")
      else
        render 'new'
      end
    end
  end
end
