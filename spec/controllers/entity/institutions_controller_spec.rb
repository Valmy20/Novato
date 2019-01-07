require 'rails_helper'

RSpec.describe Entity::InstitutionsController, type: :controller do

	before(:each) do |skip|
		session[:institution_id] = create(:institution).id
		unless skip.metadata[:skip_before]
			@institution = create(:institution)
		end
	end

  let(:valid_attributes) {
		{
			name: 'Institution name',
			email: 'institution@gmail.com',
      password: '123456',
      password_confirmation: '123456',
			status: :disapproved
		}
	}
	context "actions" do
		it { is_expected.to use_before_action(:set_item) }

	  describe "GET #new" do
	    it "returns http success" do
	      get :new
	      expect(response).to be_success if session[:institution_id].blank?
	    end
	  end

	  describe "GET #edit" do
	    it "returns http success" do
	      get :edit, params: {id: @institution.id}
	      expect(response).to be_success
	    end
	  end
	end

  context "Post #create", :skip_before do
		it "#create new Institution" do
			expect {
					post :create, params: {institution: valid_attributes}
				}.to change(Institution, :count).by(1)

		end

		it "redirects after create institution" do
			post :create, params: {institution: valid_attributes}
			expect(response).to redirect_to(entity_institution_profile_path)
		end

		it "#create with invalid params" do
			post :create, params: {
				institution: {
					name: 'jo',
					description: ''
				}
			}
			expect(response).to redirect_to(new_entity_institution_path)
		end
	end

	context "#destroy" do
		it "#destroy is deleted and redirect_to" do
				delete :destroy, params: {id: @institution.id}
				expect(response).to redirect_to(root_path)
				expect(controller).to set_flash[:notice]
		end
		it "#destroy is deleted to true" do
					expect{
					delete :destroy, params: {id: @institution.id}
				}.to change(Institution,:count).by(-1)
		end

	end

end
