class UserRewardsController < ApplicationController

  def create
    # authorize! :create, @reward
    @reward = current_user.user_rewards.new(reward_id: (params[:reward].to_i))
    if @reward && afford?
      spend_points
      @reward.save
      flash[:successful_transaction] = "Congrats on your purchase!"
      redirect_to user_path(current_user)
    else
      flash[:insufficient] = "You have insufficient non-redeemed points."
      redirect_to rewards_path
    end
  end

  private

  def afford?
    current_user.points.all.where(status: false).count >= Reward.find_by(id: params[:reward_id]).cost
  end

  def spend_points
    spent_points = current_user.points.where(status: false).take(Reward.find_by(id: params[:reward_id]).cost)
    spent_points.each do |point|
      point.update(status: true)
    end
  end

  def reward_params
    params.require(:reward).permit(:name, :cost)
  end
end
