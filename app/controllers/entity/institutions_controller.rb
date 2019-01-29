module Entity
  class InstitutionsController < EntityController
    before_action :set_item, only: %i[edit update destroy]
    before_action :authenticate_institution, only: %i[edit update profile destroy]
    layout 'entity_profile', except: %i[new create]

    def new
      redirect_to entity_institution_profile_path(current_institution) if current_institution
      @model = Institution.new
      @model.build_institution_extra if @model.institution_extra.blank?
    end

    def create
      @model = Institution.new(set_params)
      if @model.save
        session[:institution_id] = @model.id
        redirect_to entity_institution_profile_path, notice: 'Instituição cadastrada'
      else
        redirect_to new_entity_institution_path, alert: 'Verifique as informações'
      end
    end

    def edit
    end

    def update
      render :edit unless (redirect_to entity_institution_path(current_institution) if @model.update(set_params))
    end

    def destroy
      @model.deleted = true
      redirect_to root_path, notice: 'Instituição deletada' if @model.save
    end

    def profile
      @model = current_institution
      @model.build_institution_extra if @model.institution_extra.blank?
      return unless request.patch?
      return unless @model.update(set_params)

      logo = params[:institution][:logo]
      redirect_to entity_institution_profile_path, notice: 'Alterado!' unless (render :crop if logo.present?)
    end

    def update_institution_cover
      @model = current_institution
      @model.require_password_current = false
      @model.require_institution_cover = true
      return unless request.patch?
      return unless @model.update(set_params)

      render :update_institution_cover
    end

    def location
      @model = current_institution
      @model.build_institution_extra if @model.institution_extra.blank?
      return unless request.patch?
      return unless @model.update(set_params)

      render :location, notice: 'Local adicionado'
    end

    def update_password
      @model = current_institution
      @model.require_password_current = true
      return unless request.patch?

      if @model.update(set_params)
        redirect_to entity_institution_profile_path, notice: 'Senha atualizada'
      else
        render :update_password
      end
    end

    private

    def set_item
      @model = Institution.friendly.find(params[:id])
    end

    def password_blank?
      params[:institution][:password].blank? && params[:institution][:password_confirmation].blank?
    end

    def new_password_blank?
      params[:institution][:new_password].blank? && params[:institution][:new_password_confirmation].blank?
    end

    def set_params
      if_is_blank
      params.require(:institution).permit(
        :name, :email, :password, :password_confirmation, :password_current,
        :new_password, :new_password_confirmation, :logo, :cover, :crop_x,
        :crop_y, :crop_w, :crop_h, :status, institution_extra_attributes: %i[id about phone location]
      )
    end

    def if_is_blank
      params[:institution].delete(:password) if password_blank?
      params[:institution].delete(:password_confirmation) if password_blank?
      params[:institution].delete(:new_password) if new_password_blank?
      params[:institution].delete(:new_password_confirmation) if new_password_blank?
    end
  end
end
