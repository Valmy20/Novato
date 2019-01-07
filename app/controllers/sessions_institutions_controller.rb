class SessionsInstitutionsController < ApplicationController
  layout 'entity'

  def new
    redirect_to entity_institution_profile_path if current_institution.present?
  end

  def create
    institution = Institution.find_by(email: email_downcase)
    password = params[:login][:password]
    authentication_institution(institution: institution, password: password)
  end

  def destroy
    session[:institution_id] = nil
    redirect_to root_path
  end

  private

  def authentication_institution(institution:, password:)
    if institution.present? && institution.authenticate(password)
      session[:institution_id] = institution.id
      flash[:notice] = 'Login efetuado'
      redirect_to entity_institution_profile_path
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
