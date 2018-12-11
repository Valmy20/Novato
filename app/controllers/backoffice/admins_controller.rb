module Backoffice
  class AdminsController < BackofficeController
    before_action :set_item, only: %i[edit update destroy]

    def index
      @q = Admin.ransack(params[:q])
      @model = @q.result.order(id: :desc).page(params[:page]).per(10)
    end

    def new
      @model = Admin.new
    end

    def create
      @model = Admin.new(set_params)
      if @model.save
        redirect_to backoffice_admins_path, notice: 'Admin registered'
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @model.update(set_params)
        redirect_to backoffice_admins_path, notice: 'Admin updated'
      else
        render :edit
      end
    end

    def profile
      @model = current_admin
      @model.require_password_current = true
      (redirect_to backoffice_profile_path, notice: 'Profile updated' if @model.update(set_params)) if request.patch?
    end

    def destroy
      @model.deleted = true
      redirect_to backoffice_admins_path, notice: 'Admin deleted' if @model.save
    end

    private

    def set_item
      @model = Admin.find(params[:id])
    end

    def password_blank?
      params[:admin][:password].blank? &&
        params[:admin][:password_confirmation].blank?
    end

    def new_password_blank?
      params[:admin][:new_password].blank? &&
        params[:admin][:new_password_confirmation].blank?
    end

    def set_params
      if_is_blank
      params.require(:admin).permit(
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
      params[:admin].delete(:password) if password_blank?
      params[:admin].delete(:password_confirmation) if password_blank?
      params[:admin].delete(:new_password) if new_password_blank?
      params[:admin].delete(:new_password_confirmation) if new_password_blank?
    end
  end
end
