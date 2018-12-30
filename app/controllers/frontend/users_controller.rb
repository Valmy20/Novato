module Frontend
  class UsersController < FrontendController
    before_action :set_item, only: %i[show edit update destroy]
    before_action :authenticate_user, only: %i[show edit update profile destroy]
    layout 'user_profile', except: %i[new create]

    def new
      redirect_to frontend_user_path(current_user) if current_user
      @model = User.new
      @model.build_user_extra if @model.user_extra.blank?
    end

    def show
    end

    def create
      @model = User.new(set_params)
      if @model.save
        session[:user_id] = @model.id
        redirect_to frontend_user_path(@model), notice: 'User registered'
      else
        redirect_to new_frontend_user_path, alert: 'Verifique as informações'
      end
    end

    def edit
      @model.build_user_extra if @model.user_extra.blank?
    end

    def update
      render :edit unless (redirect_to frontend_user_path(current_user) if @model.update(set_params))
    end

    def destroy
      @model.deleted = true
      redirect_to root_path, notice: 'User deleted' if @model.save
    end

    def profile
      @model = current_user
      @model.build_user_extra if @model.user_extra.blank?
      return unless request.patch?
      return unless @model.update(set_params)

      avatar = params[:user][:avatar]
      msg = 'Aterações realizadas'
      (redirect_to frontend_user_path(current_user), notice: msg) unless (render :crop if avatar.present?)
    end

    def update_user_password
      @model = current_user
      @model.require_password_current = true
      return unless request.patch?

      render :update_user_password unless ((redirect_to frontend_user_path(current_user)) if @model.update(set_params))
    end

    def update_user_cover
      @model = current_user
      @model.require_password_current = false
      @model.require_user_cover = true
      return unless request.patch?

      return unless @model.update(set_params)

      render :update_user_cover unless (render :crop_cover if params[:user][:cover].present?)
    end

    def reset_password
      return unless request.post?

      @model = User.where(email: params[:user][:email]).last
      if @model
        UserMailer.reset_password(@model).deliver_now
        redirect_to new_session_user_path, notice: 'Pedido de nova senha enviado, vefirique seu email.'
      else
        flash[:alert] = 'Email não cadastrado !'
      end
    end

    def verify_token_reset
      @model = User.where(token_reset: params[:token]).last
      return nil if @model.blank?

      reset = @model
      password = SecureRandom.hex(8)
      reset.regenerate_token_reset
      reset.update(password: password)
      UserMailer.send_new_password(reset, password).deliver_now
      redirect_to new_session_user_path, notice: 'A nova senha foi enviada para o seu email !'
    end

    private

    def set_item
      @model = User.friendly.find(params[:id])
    end

    def password_blank?
      params[:user][:password].blank? &&
        params[:user][:password_confirmation].blank?
    end

    def new_password_blank?
      params[:user][:new_password].blank? &&
        params[:user][:new_password_confirmation].blank?
    end

    def set_params
      if_is_blank
      params.require(:user).permit(
        :name, :email, :password, :password_confirmation, :password_current, :new_password,
        :new_password_confirmation, :status, :avatar, :crop_x, :crop_y, :crop_w, :crop_h, :cover, :cropc_x,
        :cropc_y, :cropc_w, :cropc_h, user_extra_attributes: %i[bio phone], skills_attributes: %i[id name _destroy]
      )
    end

    def if_is_blank
      params[:user].delete(:password) if password_blank?
      params[:user].delete(:password_confirmation) if password_blank?
      params[:user].delete(:new_password) if new_password_blank?
      params[:user].delete(:new_password_confirmation) if new_password_blank?
    end
  end
end
