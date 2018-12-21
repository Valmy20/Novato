module Company
  class EmployersController < CompanyController
    before_action :set_item, only: %i[show edit update destroy]
    # before_action :authenticate_employer, only: %i[show edit update profile destroy]

    def new
      @model = Employer.new
    end

    def show
    end

    def create
      @model = Employer.new(set_params)
      if @model.save
        redirect_to company_employer_profile_path, notice: 'Employer registered'
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
      @model = Employer.last
      return unless request.patch?
      return unless @model.update(set_params)

      render :profile
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
      params[:employer].delete(:password) if password_blank?
      params[:employer].delete(:password_confirmation) if password_blank?
      params[:employer].delete(:new_password) if new_password_blank?
      params[:employer].delete(:new_password_confirmation) if new_password_blank?
    end
  end
end
