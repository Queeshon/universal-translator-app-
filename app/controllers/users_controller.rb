class UsersController < ApplicationController
  #this controller is for the creation of new users.

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
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
