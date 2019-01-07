class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_admin, :current_user, :current_employer, :current_institution

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

  def current_employer
    employer = Employer.where(id: session[:employer_id]).last
    @current_employer ||= employer if session[:employer_id] && employer
  end

  def authenticate_employer
    redirect_to sessions_employer_path unless current_employer
  end

  def current_institution
    institution = Institution.where(id: session[:institution_id]).last
    @current_institution ||= institution if session[:institution_id] && institution
  end

  def authenticate_institution
    redirect_to sessions_institution_path unless current_institution
  end
end
