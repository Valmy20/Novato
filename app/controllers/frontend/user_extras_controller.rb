module Frontend
  class UserExtrasController < FrontendController
    def update_user_bio
      @model = current_user
      return unless request.patch?
      return unless @model.update(set_bio)

      msg = 'Aterações realizadas'
      redirect_to frontend_user_path(@model), notice: msg
    end

    def update_user_skill
      @model = current_user
      return unless request.patch?

      if params[:user].present?
        msg = 'Alterações realizadas'
        redirect_to frontend_user_path(@model), notice: msg if @model.update(set_skill)
      else
        render :update_user_skill
      end
    end

    private

    def set_bio
      params.require(:user).permit(
        user_extra_attributes: %i[id bio]
      )
    end

    def set_skill
      params.require(:user).permit(
        skills_attributes: %i[id name _destroy]
      )
    end
  end
end
