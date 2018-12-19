module Backoffice
  class UsersController < BackofficeController
    before_action :set_item, only: %i[show update_status]

    def index
      @q = User.ransack(params[:q])
      @model = @q.result.order(id: :desc).page(params[:page]).per(10)
    end

    def show
      @model.build_user_extra if @model.user_extra.blank?
    end

    def update_status
      @model.status = if @model.approved?
                        :disapproved
                      else
                        :approved
                      end
      redirect_to backoffice_users_path, notice: 'Status alterado' if @model.save
    end

    private

    def set_item
      @model = User.friendly.find(params[:id])
    end
  end
end
