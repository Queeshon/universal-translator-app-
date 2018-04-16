class SessionsController < ApplicationController
  before_action :get_user, only: [:create, :show]

  def new
  end

  def create
    return head(:forbidden) unless @user.authenticate(params[:password])
    session[:username] = @user.username
    redirect_to welcome_path
  end

  def show
    #byebug
  end

  def destroy
    session.delete :username
    redirect_to login_path
  end

  private

  def get_user
    @user = User.find_by(username: session[:username])
  end

end
