module Entity
  class InstitutionsController < EntityController
    before_action :set_item, only: %i[edit update destroy]
    layout 'institution', except: %i[new create]
    layout 'institution_profile', except: %i[new create]

    def new
      redirect_to entity_institution_profile_path(current_institution) if current_institution
      @model = Institution.new
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
      return unless request.patch?
      return unless @model.update(set_params)

      msg = 'Aterações realizadas'
      redirect_to entity_institution_profile_path, notice: msg
    end

    private

    def set_item
      @model = Institution.friendly.find(params[:id])
    end

    def password_blank?
      params[:institution][:password].blank? &&
        params[:institution][:password_confirmation].blank?
    end

    def new_password_blank?
      params[:institution][:new_password].blank? &&
        params[:institution][:new_password_confirmation].blank?
    end

    def set_params
      if_is_blank
      params.require(:institution).permit(
        :name, :email, :password, :password_confirmation,
        :password_current, :new_password, :new_password_confirmation, :status
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
