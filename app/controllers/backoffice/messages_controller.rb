module Backoffice
  class MessagesController < BackofficeController
    before_action :set_item, only: %i[show destroy]

    def index
      @q = Message.ransack(params[:q])
      @model = @q.result.order(id: :desc).page(params[:page]).per(5)
    end

    def show
    end

    def destroy
      @model.deleted = true
      redirect_to backoffice_messages_path, notice: 'Mensagem deletada' if @model.save
    end

    private

    def set_item
      @model = Message.find(params[:id])
    end

    def set_params
      params.require(:message).permit(:email, :body)
    end
  end
end
