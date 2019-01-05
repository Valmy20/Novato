require 'rails_helper'

RSpec.describe Company::EmployersController, type: :controller do

	before(:each) do |skip|
		session[:employer_id] = create(:employer).id
		unless skip.metadata[:skip_before]
			@employer = create(:employer)
		end
	end

  let(:valid_attributes) {
		{
			name: 'Employer name',
			email: 'employer@gmail.com',
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
	      expect(response).to be_success if session[:employer_id].blank?
	    end
	  end

	  describe "GET #edit" do
	    it "returns http success" do
	      get :edit, params: {id: @employer.id}
	      expect(response).to be_success
	    end
	  end
	end

  context "Post #create", :skip_before do
		it "#create new Employer" do
			expect {
					post :create, params: {employer: valid_attributes}
				}.to change(Employer, :count).by(1)

		end

		it "redirects after create employer" do
			post :create, params: {employer: valid_attributes}
			expect(response).to redirect_to(company_employer_profile_path)
		end

		it "#create with invalid params" do
			post :create, params: {
				employer: {
					name: 'jo',
					description: ''
				}
			}
			expect(response).to redirect_to(new_company_employer_path)
		end
	end

	context "#destroy" do
		it "#destroy is deleted and redirect_to" do
				delete :destroy, params: {id: @employer.id}
				expect(response).to redirect_to(root_path)
				expect(controller).to set_flash[:notice]
		end
		it "#destroy is deleted to true" do
					expect{
					delete :destroy, params: {id: @employer.id}
				}.to change(Employer,:count).by(-1)
		end

	end

end
