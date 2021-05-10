module Admin
  class TeamsController < AdminController
    before_action :find_team, only: %i[edit update destroy]

    def index
      @teams = current_company.teams
    end

    def new
      @team = current_company.teams.new
    end

    def edit; end

    def update
      if @team.update(team_params)
        redirect_to admin_teams_url, notice: 'autoForm.teamUpdated'
      else
        render 'edit'
      end
    end

    def create
      @team = current_company.teams.create(team_params)

      if @team.valid?
        redirect_to admin_teams_url, notice: 'autoForm.teamCreated'
      else
        render 'new'
      end
    end

    def destroy
      @team.destroy
      redirect_to admin_teams_url, notice: 'autoForm.teamDeleted'
    end

    private

    def team_params
      params.require(:team).permit(:name)
    end

    def find_team
      @team = current_company.teams.find(params[:id])
    end
  end
end

