class SessionsController < ApplicationController
  before_action :get_user, only: [:show, :your_chatrooms]

  def new
  end

  def create
    #byebug
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:username] = @user.username
      redirect_to welcome_path
    else
      #flash[:errors] << "Invalid username/password combination."
      redirect_to login_path
    end
  end

  def show
    #byebug
  end

  def your_chatrooms
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
