require "rails_helper"

RSpec.describe Company::EmployersController, type: :routing do

  describe "routing" do

    it "routes to #new" do
      expect(:get => new_company_employer_path).to route_to("company/employers#new")
    end

		it "routes to #create" do
      expect(:post => company_employers_path).to route_to("company/employers#create")
    end

		it "routes to #edit" do
      expect(:get => edit_company_employer_path(1)).to route_to("company/employers#edit", id: '1')
    end

    context "routes to #profile" do
      it 'get' do
        expect(:get => company_employer_profile_path).to route_to("company/employers#profile")
      end

      it 'patch' do
        expect(:patch => company_employer_profile_path).to route_to("company/employers#profile")
      end
    end

		it "routes to #update" do
      expect(:put => company_employer_path(1)).to route_to("company/employers#update", id: '1')
    end

    it "routes to #detroy" do
      expect(:delete => company_employer_path(1)).to route_to("company/employers#destroy", :id => '1')
    end
  end
end
