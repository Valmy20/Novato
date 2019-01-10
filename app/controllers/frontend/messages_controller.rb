module Frontend
  class MessagesController < FrontendController
    def new_message
      if request.post?
        @model = Message.new(set_params)
        if @model.save
          redirect_to root_path, notice: 'Mensagem enviada'
        else
          render :new_message
        end
      else
        @model = Message.new
      end
    end

    private

    def set_params
      params.require(:message).permit(:email, :body) if params[:message].present?
    end
  end
end
