module Company
  class EmployersController < CompanyController
    before_action :set_item, only: %i[edit update destroy]
    before_action :authenticate_employer, only: %i[edit update profile destroy]
    layout 'company', only: %i[new create reset_password]
    layout 'company_profile', except: %i[new create reset_password]

    def new
      redirect_to company_employer_profile_path(current_employer) if current_employer
      @model = Employer.new
      @model.build_employer_extra if @model.employer_extra.blank?
    end

    def create
      @model = Employer.new(set_params)
      if @model.save
        session[:employer_id] = @model.id
        redirect_to company_employer_profile_path, notice: 'Cadastro realizado'
      else
        render :new
      end
    end

    def edit
    end

    def update
      render :edit unless (redirect_to company_employer_path(current_employer) if @model.update(set_params))
    end

    def destroy
      @model.deleted = true
      redirect_to root_path, notice: 'Employer deleted' if @model.save
    end

    def profile
      @model = current_employer
      @model.build_employer_extra if @model.employer_extra.blank?
      return unless request.patch?
      return unless @model.update(set_params)

      logo = params[:employer][:logo]
      msg = 'Aterações realizadas'
      (redirect_to company_employer_profile_path, notice: msg) unless (render :crop if logo.present?)
    end

    def update_employer_cover
      @model = current_employer
      @model.require_password_current = false
      @model.require_employer_cover = true
      return unless request.patch?

      if @model.update(set_params)
        redirect_to company_employer_profile_path, notice: 'Aterações realizadas'
      else
        render :update_employer_cover
      end
    end

    def reset_password
      return unless request.post?

      @model = Employer.where(email: params[:employer][:email]).last
      if @model
        EmployerMailer.reset_password(@model).deliver_now
        redirect_to new_session_employer_path, notice: 'Pedido de nova senha enviado, vefirique seu email.'
      else
        flash[:alert] = 'Email não cadastrado !'
      end
    end

    def location
      @model = current_employer
      @model.build_employer_extra if @model.employer_extra.blank?
      return unless request.patch?
      return unless @model.update(set_params)

      flash[:notice] = 'Local adicionado'
      render :location, notice: 'Local adicionado'
    end

    def update_employer_password
      @model = current_employer
      @model.require_password_current = true
      return unless request.patch?

      if @model.update(set_params)
        redirect_to company_employer_profile_path, notice: 'Senha atualizada'
      else
        render :update_employer_password
      end
    end

    def verify_token_reset
      @model = Employer.where(token_reset: params[:token]).last
      return nil if @model.blank?

      reset = @model
      password = SecureRandom.hex(8)
      reset.regenerate_token_reset
      reset.update(password: password)
      EmployerMailer.send_new_password(reset, password).deliver_now
      redirect_to new_session_employer_path, notice: 'A nova senha foi enviada para o seu email !'
    end

    private

    def set_item
      @model = Employer.friendly.find(params[:id])
    end

    def password_blank?
      params[:employer][:password].blank? &&
        params[:employer][:password_confirmation].blank?
    end

    def new_password_blank?
      params[:employer][:new_password].blank? &&
        params[:employer][:new_password_confirmation].blank?
    end

    def set_params
      if_is_blank
      params.require(:employer).permit(
        :name, :email, :password, :password_confirmation,
        :password_current, :new_password, :new_password_confirmation, :status, :cover,
        :logo, :crop_x, :crop_y, :crop_w, :crop_h, employer_extra_attributes: %i[id about phone location]
      )
    end

    def if_is_blank
      params[:employer].delete(:password) if password_blank?
      params[:employer].delete(:password_confirmation) if password_blank?
      params[:employer].delete(:new_password) if new_password_blank?
      params[:employer].delete(:new_password_confirmation) if new_password_blank?
    end
  end
end
