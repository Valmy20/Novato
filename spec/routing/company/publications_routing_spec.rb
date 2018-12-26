require "rails_helper"

RSpec.describe Company::PublicationsController, type: :routing do

  describe "routing" do

    it "routes to #index" do
      expect(:get => company_publications_path).to route_to("company/publications#index")
    end

    it "routes to #new" do
      expect(:get => new_company_publication_path).to route_to("company/publications#new")
    end

		it "routes to #create" do
      expect(:post => company_publications_path).to route_to("company/publications#create")
    end

    it "routes to #show" do
      expect(:get => company_publication_path(1)).to route_to("company/publications#show", id: '1')
    end

		it "routes to #edit" do
      expect(:get => edit_company_publication_path(1)).to route_to("company/publications#edit", id: '1')
    end

		it "routes to #update" do
      expect(:put => company_publication_path(1)).to route_to("company/publications#update", id: '1')
    end

    it "routes to #detroy" do
      expect(:delete => company_publication_path(1)).to route_to("company/publications#destroy", :id => '1')
    end
  end
end
