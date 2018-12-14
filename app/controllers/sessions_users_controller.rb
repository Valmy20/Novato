class SessionsUsersController < ApplicationController
  layout 'application'

  def new
    redirect_to frontend_user_path(current_user) if current_user.present?
  end

  def create
    user = User.find_by(email: email_downcase)
    password = params[:login][:password]
    authentication_user(user: user, password: password)
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def authentication_user(user:, password:)
    if user.present? && user.authenticate(password)
      session[:user_id] = user.id
      flash[:notice] = 'Login efetuado'
      redirect_to frontend_user_path(current_user)
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
