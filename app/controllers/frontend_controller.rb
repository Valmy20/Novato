class FrontendController < ApplicationController
  before_action :search

  def index
  end

  def search
    @q = Publication.ransack(params[:q])
    @model = @q.result.page(params[:page]).per(10)
  end
end
