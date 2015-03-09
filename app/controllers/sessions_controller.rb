class SessionsController < ApplicationController
  before_action :set_user, only: [:create, :destroy]

  def new
  end

  def create
  user = User.find_by(name: params[:session][:name])
  current_user = user
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:welcome] = "Welcome, #{user.name}!"
      redirect_to user_path(user)
    else
      flash[:error] = "Invalid login"
      render :new
    end
  end

  def destroy
    flash[:farewell] = "Goodbye, #{@user.name}!"
    session[:user_id] = nil
    current_user = nil
    redirect_to login_path
  end

  def set_user
    @user = User.find_by(id: session[:user_id])
  end

end
