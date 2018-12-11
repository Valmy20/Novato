require "rails_helper"

RSpec.describe Backoffice::AdminsController, type: :routing do

  describe "routing" do


    it "routes to #index" do
      expect(:get => backoffice_admins_path).to route_to("backoffice/admins#index")
    end

		it "routes to #new" do
      expect(:get => new_backoffice_admin_path).to route_to("backoffice/admins#new")
    end

		it "routes to #create" do
      expect(:post => backoffice_admins_path).to route_to("backoffice/admins#create")
    end

		it "routes to #edit" do
      expect(:get => edit_backoffice_admin_path(1)).to route_to("backoffice/admins#edit", id: '1')
    end

    context "routes to #profile" do
      it 'get' do
        expect(:get => backoffice_profile_path).to route_to("backoffice/admins#profile")
      end

      it 'patch' do
        expect(:patch => backoffice_profile_path).to route_to("backoffice/admins#profile")
      end
    end

		it "routes to #update" do
      expect(:put => backoffice_admin_path(1)).to route_to("backoffice/admins#update", id: '1')
    end

		it "routes to #detroy" do
      expect(:delete => backoffice_admin_path(1)).to route_to("backoffice/admins#destroy", :id => '1')
    end

  end
end
