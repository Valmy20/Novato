module Backoffice
  class InstitutionsController < BackofficeController
    before_action :set_item, only: %i[show update_status]

    def index
      @q = Institution.ransack(params[:q])
      @model = @q.result.order(id: :desc).page(params[:page]).per(10)
    end

    def show
    end

    def update_status
      @model.status = if @model.approved?
                        :disapproved
                      else
                        :approved
                      end
      redirect_to backoffice_institutions_path, notice: 'Status alterado' if @model.save
    end

    private

    def set_item
      @model = Institution.find_by(id: params[:id])
    end
  end
end
