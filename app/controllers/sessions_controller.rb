class SessionsController < ApplicationController
  protect_from_forgery with: :exception
  skip_before_action :require_login!, only: [:new, :create, :failure, :redirect]

  def new
    # renders login page
  end

  def redirect
    redirect_to "/auth/oidc", status: 307 # preserves POST
  end

  def create
    auth = request.env["omniauth.auth"]
    info = auth["info"] || {}
    uid  = auth["uid"]

    user = User.find_or_initialize_by(provider: "oidc", uid: uid)
    user.update!(email: info["email"], name: info["name"])

    session[:user_id] = user.id
    redirect_to root_path, notice: "Signed in"
  end

  def failure
    redirect_to login_path, alert: "Login failed: #{params[:message]}"
  end

  def destroy
    reset_session
    redirect_to login_path, notice: "Signed out"
  end
end