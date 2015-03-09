class RewardsController < ApplicationController
  before_filter :logged_in?
  before_action :set_reward, only: [:show, :edit, :update, :destroy]

  def index
    authorize! :read, Reward
    @users = User.all
    @rewards = Reward.all
  end

  def show
    authorize! :read, @reward
    @rewards = User.find_by(params[:username]).rewards
  end

  def new
    authorize! :create, @reward
    @reward = Reward.new
  end

  def edit
    authorize! :edit, @reward
  end

  def update
    authorize! :edit, @reward
    if @reward.update(reward_params)
      redirect_to @reward
    else
      render :edit
    end
  end

  def create
    authorize! :create, @reward
    @reward = current_user.rewards.new(reward_params)
    if @reward.save
      redirect_to @reward
    else
      render :new
    end
  end

  def destroy
    authorize! :delete, @reward
    @reward.user_rewards.destroy_all
    @reward.destroy
    redirect_to rewards_path
  end

  private

  def set_reward
    @reward = Reward.find(params[:id])
  end

  def reward_params
    params.require(:reward).permit(:name, :cost)
  end

  def logged_in?
    if current_user.nil?
      redirect_to login_path, alert: "Not authorized"
    end
  end
end
