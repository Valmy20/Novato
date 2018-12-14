module Frontend
  class UsersController < FrontendController
    before_action :set_item, only: %i[edit update destroy]

    def new
      @model = User.new
    end

    def create
      @model = User.new(set_params)
      if @model.save
        redirect_to frontend_user_profile_path, notice: 'User registered'
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @model.update(set_params)
        redirect_to frontend_users_path, notice: 'User updated'
      else
        render :edit
      end
    end

    def profile
      @model = User.last
      @model.build_user_extra if @model.user_extra.blank?
      @model.require_password_current = true
      (redirect_to frontend_user_profile_path, notice: 'Profile updated' if @model.update(set_params)) if request.patch?
    end

    def destroy
      @model.deleted = true
      redirect_to new_frontend_user_path, notice: 'User deleted' if @model.save
    end

    private

    def set_item
      @model = User.find(params[:id])
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
        :status
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
