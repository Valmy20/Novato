module Contributor
  class CollaboratorsController < ContributorController
    before_action :set_item, only: %i[edit update destroy]
    before_action :authenticate_collaborator, only: %i[index edit update profile destroy]
    layout 'contributor_profile', only: %i[profile]

    def index
    end

    def new
      redirect_to contributor_collaborator_profile_path if current_collaborator
      @model = Collaborator.new
    end

    def create
      @model = Collaborator.new(set_params)
      if @model.save
        session[:collaborator_id] = @model.id
        redirect_to contributor_collaborator_profile_path, notice: 'Contribuidor registrado'
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @model.update(set_params)
        redirect_to contributor_collaborator_profile_path, notice: 'Alterações realizadas'
      else
        render :edit
      end
    end

    def destroy
      @model.deleted = true
      redirect_to root_path, notice: 'Contribuidor deletado' if @model.save
    end

    def profile
      @model = current_collaborator
      @model.require_password_current = true
      return unless request.patch?

      msg = 'Perfil editado'
      redirect_to contributor_collaborators_path, notice: msg if @model.update(set_params)
    end

    private

    def set_item
      @model = Collaborator.find(params[:id])
    end

    def password_blank?
      params[:collaborator][:password].blank? &&
        params[:collaborator][:password_confirmation].blank?
    end

    def new_password_blank?
      params[:collaborator][:new_password].blank? &&
        params[:collaborator][:new_password_confirmation].blank?
    end

    def set_params
      if_is_blank
      params.require(:collaborator).permit(
        :name,
        :email,
        :password,
        :password_confirmation,
        :password_current,
        :new_password,
        :new_password_confirmation
      )
    end

    def if_is_blank
      params[:collaborator].delete(:password) if password_blank?
      params[:collaborator].delete(:password_confirmation) if password_blank?
      params[:collaborator].delete(:new_password) if new_password_blank?
      params[:collaborator].delete(:new_password_confirmation) if new_password_blank?
    end
  end
end
