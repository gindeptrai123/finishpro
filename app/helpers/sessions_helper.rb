module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def log_out
    session.delete :user_id
  end

  def logged_in?
    session[:user_id].present?
  end

  def current_user? user
    user == current_user
  end

  def current_user
    return unless user_id = session[:user_id]
    @current_user ||= User.find_by(id: user_id)
  end

  def check_is_admin?
    current_user.admin?
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
