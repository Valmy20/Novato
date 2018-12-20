require "rails_helper"

RSpec.describe Frontend::UsersController, type: :routing do

  describe "routing" do

		it "routes to #new" do
      expect(:get => new_frontend_user_path).to route_to("frontend/users#new")
    end

		it "routes to #create" do
      expect(:post => frontend_users_path).to route_to("frontend/users#create")
    end

		it "routes to #edit" do
      expect(:get => edit_frontend_user_path(1)).to route_to("frontend/users#edit", id: '1')
    end

    context "routes to #profile" do
      it 'get' do
        expect(:get => frontend_user_profile_path).to route_to("frontend/users#profile")
      end

      it 'patch' do
        expect(:patch => frontend_user_profile_path).to route_to("frontend/users#profile")
      end
    end

		it "routes to #update" do
      expect(:put => frontend_user_path(1)).to route_to("frontend/users#update", id: '1')
    end

    it "routes to #detroy" do
      expect(:delete => frontend_user_path(1)).to route_to("frontend/users#destroy", :id => '1')
    end

  end
end
