class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_admin, :current_user

  private

  def current_admin
    admin = Admin.where(id: session[:admin_id]).last
    @current_admin ||= admin if session[:admin_id] && admin
  end

  def authenticate_admin
    redirect_to sessions_path unless current_admin
  end

  def current_user
    user = User.where(id: session[:user_id]).last
    @current_user ||= user if session[:user_id] && user
  end

  def authenticate_user
    redirect_to sessions_user_path unless current_user
  end
end
