class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:username] = @user.username
      redirect_to welcome_path
    else
      flash[:errors] << "Invalid username/password combination."
      redirect_to login_path
    end
  end

  def show
    #byebug
    @user = User.find_by(username: session[:username])
  end

  def destroy
    session.delete :username
    redirect_to login_path
  end

  private

end
