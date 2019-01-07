require "rails_helper"

RSpec.describe Entity::InstitutionsController, type: :routing do

  describe "routing" do

    it "routes to #new" do
      expect(:get => new_entity_institution_path).to route_to("entity/institutions#new")
    end

		it "routes to #create" do
      expect(:post => entity_institutions_path).to route_to("entity/institutions#create")
    end

		it "routes to #edit" do
      expect(:get => edit_entity_institution_path(1)).to route_to("entity/institutions#edit", id: '1')
    end

    context "routes to #profile" do
      it 'get' do
        expect(:get => entity_institution_profile_path).to route_to("entity/institutions#profile")
      end

      it 'patch' do
        expect(:patch => entity_institution_profile_path).to route_to("entity/institutions#profile")
      end
    end

		it "routes to #update" do
      expect(:put => entity_institution_path(1)).to route_to("entity/institutions#update", id: '1')
    end

    it "routes to #detroy" do
      expect(:delete => entity_institution_path(1)).to route_to("entity/institutions#destroy", :id => '1')
    end
  end
end
