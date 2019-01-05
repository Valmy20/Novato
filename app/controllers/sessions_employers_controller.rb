class SessionsEmployersController < ApplicationController
  layout 'company'

  def new
    redirect_to company_employer_profile_path if current_employer.present?
  end

  def create
    employer = Employer.find_by(email: email_downcase)
    password = params[:login][:password]
    authentication_employer(employer: employer, password: password)
  end

  def destroy
    session[:employer_id] = nil
    redirect_to root_path
  end

  private

  def authentication_employer(employer:, password:)
    if employer.present? && employer.authenticate(password)
      session[:employer_id] = employer.id
      flash[:notice] = 'Login efetuado'
      redirect_to company_employer_profile_path
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
