module Backoffice
  class CategoriesController < BackofficeController
    before_action :set_item, only: %i[edit update destroy]

    def index
      @q = Category.ransack(params[:q])
      @model = @q.result.order(id: :desc).page(params[:page]).per(10)
    end

    def new
      @model = Category.new
    end

    def create
      @model = Category.new(set_params)
      @model.admin_id = current_admin.id

      if @model.save
        redirect_to backoffice_categories_path, notice: 'Category registered'
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @model.update(set_params)
        redirect_to backoffice_categories_path, notice: 'Category updated'
      else
        render :edit
      end
    end

    def destroy
      redirect_to backoffice_categories_path, notice: 'Category deleted' if @model.update(deleted: true)
    end

    private

    def set_item
      @model = Category.friendly.find(params[:id])
    end

    def set_params
      params.require(:category).permit(
        :name,
        :status
      )
    end
  end
end
