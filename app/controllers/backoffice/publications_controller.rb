module Backoffice
  class PublicationsController < BackofficeController
    before_action :set_item, only: %i[show destroy update_status]

    def index
      @q = Publication.ransack(params[:q])
      @model = @q.result.order(id: :desc).page(params[:page]).per(5)
    end

    def show
    end

    def update_status
      msg = 'Status atualizado'
      (redirect_to backoffice_publications_path, notice: msg if @model.update!(set_params)) if request.patch?
    end

    def destroy
      @model.deleted = true
      redirect_to backoffice_messages_path, notice: 'Mensagem deletada' if @model.save
    end

    private

    def set_item
      @model = Publication.friendly.find(params[:id])
    end

    def set_params
      params.require(:publication).permit(:status)
    end
  end
end
