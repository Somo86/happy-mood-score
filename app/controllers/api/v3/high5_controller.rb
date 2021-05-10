module Api
  module V3
    class High5Controller < ApiController
      before_action :validate_manager, only: %i[index]

      def index
        @high5s = High5::Finder.new(current_company, high5_params).all.page(params[:page]).per(100)
      end

      def create
        @high5 = Activities::High5.create(sender, receiver, params[:message])

        if @high5.persisted?
          render partial: 'api/v3/high5/high5', locals: { high5: @high5 }
        else
          render json: @high5.errors
        end
      end

      private

      def high5_params
        {
          receiver_id: params[:receiver_id].present? ? receiver.id : nil,
          sender_id: params[:sender_id].present? ? sender.id : nil,
          start_date: params[:start_date].to_s,
          end_date: params[:end_date].to_s
        }
      end

      def receiver
        current_company.employees.find_by!(uuid: params[:receiver_id])
      end

      def sender
        if current_employee.manager?
          current_company.employees.find_by!(uuid: params[:sender_id])
        else
          current_employee
        end
      end

      def validate_manager
        raise User::Unauthorised unless current_employee.manager?
      end
    end
  end
end
