class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :require_login!

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_login!
    return if current_user.present?
    redirect_to login_path, alert: "Please sign in"
  end
end
