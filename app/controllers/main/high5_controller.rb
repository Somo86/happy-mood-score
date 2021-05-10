module Main
  class High5Controller < UserController
    before_action :find_receiver, only: %i[new create]
    before_action :find_team_id, only: %i[index search]

    def index
      @employees = employees_list
    end

    def new; end

    def create
      @high5 = Activities::High5.create(current_employee, @receiver, params[:description])
      @success = @high5.valid?

      render 'new'
    end

    def search
      @employees = employees_list

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update('employees-list', partial: 'main/high5/employee', collection: @employees)
        end

        format.html { redirect_to main_high5_index_url }
      end
    end


    private

    def find_receiver
      @receiver = current_company.employees.active.find(params[:receiver_id])
    end

    def find_team_id
      @team_id = current_employee.team_id
      params[:team_id] ||= @team_id
    end

    def employees_list
      Employees::Finder.new(current_company, params).all
    end
  end
end

