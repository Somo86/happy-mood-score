module Admin
  class RewardsController < ::AdminController
    before_action :find_reward, only: %i[show edit update destroy]

    def index
      @rewards = current_company.rewards.order(:active, :category, :name).page(params[:page])
    end

    def show; end

    def new; end

    def edit; end

    def create
      @reward = current_company.rewards.create(reward_params)

      if @reward.errors.empty?
        redirect_to admin_rewards_path, notice: 'Reward created successfully.'
      else
        render partial: 'form'
      end
    end

    def update
      @reward.update(reward_params)

      if @reward.errors.empty?
        redirect_to admin_rewards_path, notice: 'Reward updated successfully.'
      else
        render partial: 'form'
      end
    end

    def destroy
      @reward.destroy

      if @reward.errors.empty?
        redirect_to admin_rewards_path, notice: 'Reward deleted successfully.'
      else
        redirect_to admin_rewards_path, error: 'Active rewards can not be deleted.'
      end
    end

    private

    def reward_params
      params.require(:reward).permit(%i[name category description])
    end

    def find_reward
      @reward = current_company.rewards.find(params[:id])
    end
  end
end
