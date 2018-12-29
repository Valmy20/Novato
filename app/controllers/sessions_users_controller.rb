class SessionsUsersController < ApplicationController
  layout 'frontend'

  def new
    redirect_to frontend_user_path(current_user) if current_user.present?
  end

  def create
    if params[:provider].present?
      provider
    else
      user = User.find_by(email: email_downcase)
      password = params[:login][:password]
      authentication_user(user: user, password: password)
    end
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

  def provider
    @user = User.create_from_auth_hash(auth: auth_hash)
    User.update_user(user: @user.id, code: cookies[:code]) if cookies[:code].present?
    if @user.id.nil?
      redirect_to new_session_user_path, alert: 'O email desse Facebook já possui cadastro !'
    else
      session[:user_id] = @user.id
      redirect_to frontend_user_path(@user), notice: 'Logado com Facebook'
    end
  end

  def auth_hash
    request.env['omniauth.auth']
  end

  def email_downcase
    email = params[:login][:email]
    email.downcase if email.present?
  end
end
