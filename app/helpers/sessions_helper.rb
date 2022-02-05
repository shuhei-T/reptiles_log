module SessionsHelper
  def current_user?(user)
    user == current_user
  end

  def log_in(user)
    session[:user_id] = user.id
  end
end