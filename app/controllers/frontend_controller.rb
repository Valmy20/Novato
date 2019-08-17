class FrontendController < ApplicationController
  before_action :search, only: %i[index]

  before_action only: [:search] do
    get_query('query_publication')
  end

  def index
  end

  def search
    @q = Publication.ransack(@query)
    if params[:search].present?
      if params[:search][:filter] == "emprego"
        @model = @q.result.available_publication.filter_job_posts.order(id: :desc).page(params[:page]).per(10)
      elsif params[:search][:filter] == "estagio"
        @model = @q.result.available_publication.filter_internship_posts.order(id: :desc).page(params[:page]).per(10)
      end
    else
      @model = @q.result.available_publication.order(id: :desc).page(params[:page]).per(10)
    end
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

  def search_user
    @q = User.ransack(params[:q])
    result = @q.result.includes(:skills).order(id: :desc).to_a.uniq
    @model = Kaminari.paginate_array(result).page(params[:page]).per(10)
  end

  def show_user
    @model = User.friendly.find(params[:id])
  end
end
