require "rails_helper"

RSpec.describe Backoffice::CategoriesController, type: :routing do

  describe "routing" do


    it "routes to #index" do
      expect(:get => backoffice_categories_path).to route_to("backoffice/categories#index")
    end

		it "routes to #new" do
      expect(:get => new_backoffice_category_path).to route_to("backoffice/categories#new")
    end

		it "routes to #create" do
      expect(:post => backoffice_categories_path).to route_to("backoffice/categories#create")
    end

		it "routes to #edit" do
      expect(:get => edit_backoffice_category_path(1)).to route_to("backoffice/categories#edit", id: '1')
    end

		it "routes to #update" do
      expect(:put => backoffice_category_path(1)).to route_to("backoffice/categories#update", id: '1')
    end

		it "routes to #detroy" do
      expect(:delete => backoffice_category_path(1)).to route_to("backoffice/categories#destroy", :id => '1')
    end

  end
end
