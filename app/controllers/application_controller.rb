class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_admin

  private

  def current_admin
    admin = Admin.where(id: session[:admin_id]).last
    @current_admin ||= admin if session[:admin_id] && admin
  end

  def authenticate_admin
    redirect_to sessions_path unless current_admin
  end
end
