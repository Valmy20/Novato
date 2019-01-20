module Frontend
  class CompetesController < FrontendController
    def apply_publication
      publication = Publication.find_by(id: params[:id])
      if current_user.present?
        @model = Compete.find_by(user_id: current_user.id, publication_id: publication.id)
        if @model.present?
          msg = 'Você parou de concorrer a esta vaga'
          redirect_to show_publication_path(publication), alert: msg if @model.destroy
        else
          user_id = current_user.id
          msg = 'Você está concorrendo a esta vaga'
          @model = Compete.new(user_id: user_id, publication_id: publication.id)
          redirect_to show_publication_path(publication), notice: msg if @model.save
        end
      else
        redirect_to new_session_user_path, alert: 'Faça login para concorrer'
      end
    end
  end
end
