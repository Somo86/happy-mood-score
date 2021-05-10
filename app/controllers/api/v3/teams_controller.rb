module Api
  module V3
    class TeamsController < ApiManagerController
      before_action :find_team, except: %i[index create]

      def index
        @teams = current_company.teams.page(params[:page]).per(100)
      end

      def show; end

      def create
        @team = current_company.teams.create(team_params)

        if @team.persisted?
          render partial: 'api/v3/teams/team', locals: { team: @team }
        else
          render json: @team.errors
        end
      end

      def update
        if @team.update(team_params)
          render partial: 'api/v3/teams/team', locals: { team: @team }
        else
          render json: @team.errors
        end
      end

      private

      def team_params
        params.permit(:name)
      end

      def find_team
        @team = current_company.teams.find_by(uuid: params[:id])
      end
    end
  end
end
