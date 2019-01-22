module Contributor
  class PostsController < ContributorController
    before_action :set_item, only: %i[edit show update destroy visibility]
    before_action :set_others, only: %i[new create update edit]

    layout 'contributor_profile'

    def index
      @q = Post.collaborator(current_collaborator)
      @model = @q.order(id: :desc).page(params[:page]).per(10)
    end

    def new
      @model = Post.new
    end

    def show
    end

    def create
      @model = Post.new(set_params)

      @model.postable_type = 'Collaborator'
      @model.postable_id = current_collaborator.id

      if @model.save
        thumb = params[:post][:thumb]
        msg = 'Postagem adicionada'
        (redirect_to contributor_posts_path, notice: msg) unless (render :crop_thumb if thumb.present?)
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @model.update(set_params)
        thumb = params[:post][:thumb]
        msg = 'Postagem atualizada'
        (redirect_to contributor_posts_path, notice: msg) unless (render :crop_thumb if thumb.present?)
      else
        render :edit
      end
    end

    def destroy
      @model.deleted = true
      (redirect_to contributor_posts_path, notice: 'Postagem deletada') if @model.save
    end

    def visibility
      @model.visibility = if @model.visibility
                            false
                          else
                            true
                          end
      return unless @model.approved?

      redirect_to contributor_posts_path, notice: 'Alterado' if @model.save
    end

    private

    def set_item
      @model = Post.friendly.find(params[:id])
    end

    def set_others
      @categories = Category.published.map { |cat| [cat.name, cat.id] }
    end

    def set_params
      params.require(:post).permit(
        :title,
        :body,
        :slug,
        :thumb, :crop_x, :crop_y, :crop_w, :crop_h,
        category_ids: []
      )
    end
  end
end
