class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @current_user || User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user

  def sign_in_user(user, remember_me)
    if remember_me
      cookies.permanent[:auth_token] = user.auth_token
    else
      cookies[:auth_token] = user.auth_token
    end
  end
  helper_method :sign_in_user

  def sign_out_user
    cookies[:auth_token] = nil
  end
  helper_method :sign_out_user
end
