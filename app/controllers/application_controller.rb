class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  helper_method :current_user

  def current_user
    CurrentUser.new(User.find_by(id: session[:user_id]))
  end
end
