module Frontend
  class UserExtrasController < FrontendController
    layout 'user_profile'

    def update_user_bio
      @model = current_user
      @model.build_user_extra if @model.user_extra.blank?
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

    def update_user_avatar
      @model = current_user
      return unless request.patch?
      return unless @model.update(set_avatar)

      avatar = params[:user][:avatar]
      msg = 'Aterações realizadas'
      if avatar.present?
        redirect_to frontend_user_path(current_user), notice: msg unless render :crop
      else
        render :update_user_avatar
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

    def set_avatar
      params.require(:user).permit(:avatar, :crop_x, :crop_y, :crop_w, :crop_h)
    end
  end
end
