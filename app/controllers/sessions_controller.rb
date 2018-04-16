class SessionsController < ApplicationController
  before_action :get_user, only: [:create, :show]

  def new

  end

  def create
    redirect_to root_path unless @user.authenticate(params[:password])
    session[:username] = @user.username
    redirect_to welcome_path
  end

  def show
  end

  private

  def get_user
    @user = User.find_by(username: params[:username])
  end

end
