class UsersController < ApplicationController
  #this controller is for the creation of new users.

  def index
    
  end

  def show
    #byebug
    # if params[:username].scan(/\D/).empty?
    #   @user = User.find(params[:username])
    # else
    #   @user = User.find_by(username: params[:username])
    # end
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    #byebug
    @user = User.create(user_params)
    if @user.valid?
      redirect_to @user
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :username,
      :password,
      :password_confirmation,
      conversation_ids: []
    )
  end

end
