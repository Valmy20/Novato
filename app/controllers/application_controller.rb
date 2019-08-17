class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  helper_method :current_admin, :current_user, :current_employer, :current_institution, :current_collaborator

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def routing_error
    redirect_to root_path, alert: 'Algo deu erraro :('
  end

  def get_query(cookie_key)
    cookies.delete(cookie_key) if params[:clear]
    cookies[cookie_key] = params[:q].to_json if params[:q]
    @query = params[:q].presence || JSON.load(cookies[cookie_key])
  end

  private

  def user_not_authorized
    flash[:alert] = 'Você não possui autorização para realizar esta ação'
    redirect_to(request.referer || backoffice_profile_path)
  end

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

  def current_collaborator
    collaborator = Collaborator.where(id: session[:collaborator_id]).last
    @current_collaborator ||= collaborator if session[:collaborator_id] && collaborator
  end

  def authenticate_collaborator
    redirect_to sessions_collaborator_path unless current_collaborator
  end
end
