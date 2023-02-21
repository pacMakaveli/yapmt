class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?

  def current_user
    return @_user if defined?(@_user)
    @_user = User.find_by(uid: session_user_id)
  end

  def logged_in?
    current_user
  end

private

  def session_user_id
    cookies.signed[:user_uid] || (cookies.signed[:user_uid] = rand(1e12).to_s(36))
  end
end
