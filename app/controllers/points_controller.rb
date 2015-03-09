class PointsController < ApplicationController
  before_action :set_user, only: [:create, :destroy]


  def create
    authorize! :create, @point
    @user.points.create()
    flash[:point_added] = "One point has been added to #{@user.name}'s collection. Total: #{@user.points.count}!"
    redirect_to edit_user_path(@user)
  end

  def destroy
    authorize! :delete, @reward
    @user.points.last.destroy
    flash[:point_added] = "One point has been removed from #{@user.name}'s collection. Total: #{@user.points.count}!"
    redirect_to edit_user_path(@user)
  end
  private

  def set_user
    @user = User.find(params[:id])
  end

end
