class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  helper_method :logged_in?, :current_user, :authorized

  def current_user
    if session[:username]
      User.find_by(username: session[:username])
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
