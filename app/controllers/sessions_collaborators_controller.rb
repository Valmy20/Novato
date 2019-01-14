class SessionsCollaboratorsController < ApplicationController
  layout 'frontend'

  def new
    redirect_to contributor_collaborator_profile_path if current_collaborator.present?
  end

  def create
    collaborator = Collaborator.find_by(email: email_downcase)
    password = params[:login][:password]
    authentication_collaborator(collaborator: collaborator, password: password)
  end

  def destroy
    session[:collaborator_id] = nil
    redirect_to root_path
  end

  private

  def authentication_collaborator(collaborator:, password:)
    if collaborator.present? && collaborator.authenticate(password)
      session[:collaborator_id] = collaborator.id
      flash[:notice] = 'Login efetuado'
      redirect_to contributor_collaborator_profile_path
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
