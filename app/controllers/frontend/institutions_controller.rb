module Frontend
  class InstitutionsController < FrontendController
    skip_before_action :verify_authenticity_token, only: [:reset_password]

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
  end
end
