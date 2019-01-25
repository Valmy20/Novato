class FrontendController < ApplicationController
  before_action :search, only: %i[index]

  def index
  end

  def search
    @q = Publication.ransack(params[:q])
    @model = @q.result.available_publication.order(id: :desc).page(params[:page]).per(10)
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
    @model = Post.available_post.order(id: :desc).page(params[:page]).per(10)
  end

  def show_post
    @model = Post.friendly.find(params[:post])
  end

  def show_profile_employer
    id = Employer.friendly.find(params[:id])
    @model = Employer.find_by(id: id)
  end

  def show_profile_institution
    id = Institution.friendly.find(params[:id])
    @model = Institution.find_by(id: id)
  end

  def search_users
    @model = User.search(params[:search][:q]).page(params[:page]).per(10)
  end

  def show_user
    @model = User.friendly.find(params[:id])
  end

  def list_users
    users = User.order(updated_at: :desc).limit(50)
    @model = Kaminari.paginate_array(users).page(params[:page]).per(6)
  end
end
