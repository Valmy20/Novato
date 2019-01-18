class FrontendController < ApplicationController
  before_action :search, only: %i[index]

  def index
  end

  def search
    @q = Publication.ransack(params[:q])
    @model = @q.result.order(id: :desc).page(params[:page]).per(10)
  end

  def show_publication
    @model = Publication.friendly.find(params[:publication])
    id = @model.publicationable_id

    if @model.publicationable_type == 'Employer'
      @postman = Employer.find_by(id: id)
    elsif @model.publicationable_type == 'Institution'
      @postman = Institution.find_by(id: id)
    end
  end

  def posts
    @model = Post.order(id: :desc).page(params[:page]).per(10)
  end
end
