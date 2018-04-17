class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    if 
      User.find(session[:user_id])
    else
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized
    redirect_to login_path unless logged_in?
  end
end
