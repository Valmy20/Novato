class CompanyController < ApplicationController
  before_action :authenticate_employer, except: %i[confirm_email verify_token_confirm]

  def confirm_email(employer)
    EmployerMailer.confirm_email(employer).deliver_now
    redirect_to new_session_employer_path, notice: 'Verifique seu email'
  end

  def verify_token_confirm
    token_reset = params[:token]
    @model = Employer.where(token_reset: token_reset)

    return nil unless @model.exists?

    reset = @model.last
    reset.regenerate_token_reset
    reset.update(status: 1)
    redirect_to company_employer_profile_path, notice: 'Email aprovado!'
  end
end
