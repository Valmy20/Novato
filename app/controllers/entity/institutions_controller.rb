module Entity
  class InstitutionsController < EntityController
    before_action :set_item, only: %i[edit update destroy]
    before_action :authenticate_institution, only: %i[edit update profile destroy]
    layout 'entity', only: %i[new create reset_password]
    layout 'entity_profile', except: %i[new create reset_password]

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

      msg = 'Aterações realizadas'
      redirect_to entity_institution_profile_path, notice: msg
    end

    def reset_password
      return unless request.post?

      @model = Institution.where(email: params[:institution][:email]).last
      if @model
        InstitutionMailer.reset_password(@model).deliver_now
        redirect_to new_session_institution_path, notice: 'Pedido de nova senha enviado, vefirique seu email.'
      else
        flash[:alert] = 'Email não cadastrado !'
      end
    end

    def verify_token_reset
      @model = Institution.where(token_reset: params[:token]).last
      return nil if @model.blank?

      reset = @model
      password = SecureRandom.hex(8)
      reset.regenerate_token_reset
      reset.update(password: password)
      InstitutionMailer.send_new_password(reset, password).deliver_now
      redirect_to new_session_institution_path, notice: 'A nova senha foi enviada para o seu email !'
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
        :password_current, :new_password, :new_password_confirmation,
        :status, institution_extra_attributes: %i[about phone location]
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
