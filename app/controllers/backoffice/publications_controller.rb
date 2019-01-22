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
      return unless request.patch?

      return unless @model.update!(set_params)

      @model.update_attribute(:visibility, true) if @model.approved?
      redirect_to backoffice_publications_path, notice: 'Status atualizado'
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
