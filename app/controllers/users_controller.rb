class UsersController < ApplicationController
  #this controller is for the creation of new users.
  before_action :get_user, only: [:show, :edit, :update, :destroy]
  before_action :get_languages, only: [:new, :edit]
  before_action :authorized, only: [:edit, :update, :destroy, :show]

  def index
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    #byebug
    if @user.valid?
      redirect_to @user
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def edit
  end

  def update
    @user.update(user_params)

    if @user.valid?
      redirect_to @user
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to edit_user_path
    end
  end

  def destroy
    @user.destroy

    redirect_to login_path
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :username,
      :language_id,
      :password,
      :password_confirmation,
      conversation_ids: []
    )
  end

  def get_user
    @user = User.find(params[:id])
  end

  def get_languages
    @languages = Language.all
  end

end
