require "rails_helper"

RSpec.describe Contributor::CollaboratorsController, type: :routing do

  describe "routing" do

    it "routes to #new" do
      expect(:get => new_contributor_collaborator_path).to route_to("contributor/collaborators#new")
    end

		it "routes to #create" do
      expect(:post => contributor_collaborators_path).to route_to("contributor/collaborators#create")
    end

    context "routes to #profile" do
      it 'get' do
        expect(:get => contributor_collaborator_profile_path).to route_to("contributor/collaborators#profile")
      end

      it 'patch' do
        expect(:patch => contributor_collaborator_profile_path).to route_to("contributor/collaborators#profile")
      end
    end

		it "routes to #detroy" do
      expect(:delete => contributor_collaborator_path(1)).to route_to("contributor/collaborators#destroy", :id => '1')
    end

  end
end
