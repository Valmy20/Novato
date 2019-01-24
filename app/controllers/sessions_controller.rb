class SessionsController < ApplicationController
  layout 'application'

  def new
    redirect_to backoffice_profile_path if current_admin.present?
  end

  def create
    admin = Admin.find_by(email: email_downcase)
    password = params[:login][:password]
    authentication_admin(admin: admin, password: password)
  end

  def destroy
    session[:admin_id] = nil
    redirect_to new_session_path
  end

  private

  def authentication_admin(admin:, password:)
    if admin.present? && admin.authenticate(password)
      session[:admin_id] = admin.id
      flash[:notice] = 'Login efetuado'
      redirect_to backoffice_profile_path
    else
      flash[:alert] = 'E-mail ou senha incorretas'
      render :new
    end
  end

  def email_downcase
    email = params[:login][:email]
    email.downcase if email.present?
  end
end
