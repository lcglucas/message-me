class SessionsController < ApplicationController
  before_action :logged_in_redirect, only: [ :new, :create ]

  def new
    @user = User.new
  end

  def create
    user = User.find_by(username: params[:user][:username])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in"
      redirect_to root_path
    else
      flash.now[:error] = "There was something wrong with your login information"
      render "new", status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have successfully logged out"
    redirect_to login_path
  end

  private

  def logged_in_redirect
    redirect_to root_path if logged_in?
  end
end
