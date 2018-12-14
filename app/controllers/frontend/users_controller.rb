module Frontend
  class UsersController < FrontendController
    before_action :set_item, only: %i[show edit update destroy]
    before_action :authenticate_user, only: %i[show edit update profile destroy]

    def new
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
        render :new
      end
    end

    def edit
      @model.build_user_extra if @model.user_extra.blank?
    end

    def update
      if @model.update(set_params)
        redirect_to frontend_users_path, notice: 'User updated'
      else
        render :edit
      end
    end

    def profile
      @model = current_user
      @model.build_user_extra if @model.user_extra.blank?
      @model.require_password_current = true
      (redirect_to frontend_user_profile_path, notice: 'Profile updated' if @model.update(set_params)) if request.patch?
    end

    def destroy
      @model.deleted = true
      redirect_to root_path, notice: 'User deleted' if @model.save
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
        :name,
        :email,
        :password,
        :password_confirmation,
        :password_current,
        :new_password,
        :new_password_confirmation,
        :status,
        user_extra_attributes: %i[bio skill phone]
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
