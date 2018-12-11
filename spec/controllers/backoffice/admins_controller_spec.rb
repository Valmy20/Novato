require 'rails_helper'

RSpec.describe Backoffice::AdminsController, type: :controller do

	before(:each) do |skip|
		session[:admin_id] = create(:admin).id
		unless skip.metadata[:skip_before]
			@admin = create(:admin)
		end
	end
  let(:valid_attributes) {
		{
			name: Faker::Lorem.name,
			email: Faker::Internet.email,
      password: '123456',
      password_confirmation: '123456',
			status: true
		}
	}
	context "actions" do
		it { is_expected.to use_before_action(:set_item) }

	  describe "GET #index" do
	    it "returns http success" do
	      get :index
	      expect(response).to be_success
	    end
	  end

	  describe "GET #new" do
	    it "returns http success" do
	      get :new
	      expect(response).to be_success
	    end
	  end

	  describe "GET #edit" do
	    it "returns http success" do
	      get :edit, params: {id: @admin.id}
	      expect(response).to be_success
	    end
	  end
	end

	context "Post #create", :skip_before do
		it "#create new Admin" do
			expect {
					post :create, params: {admin: valid_attributes}
				}.to change(Admin, :count).by(1)

		end

		it "redirects after create admin" do
			post :create, params: {admin: valid_attributes}
			expect(response).to redirect_to(backoffice_admins_path)
		end

		it "#create with invalid params" do
			post :create, params: {
				admin: {
					name: 'jo',
					description: ''
				}
			}
			expect(response).to render_template("new")
		end
	end

	context "PUT #update", :skip_before do
		email = Faker::Internet.email
		let(:new_attributes) {
			{
					email: email
			}
		}

		it "updates the requested admin" do
			admin = create(:admin)
			put :update, params: {id: admin.id, admin: new_attributes}
			admin.reload
			expect(Admin.last.email).to eq(email)
		end

		it "redirects to the admin" do
			admin = create(:admin)
			put :update, params: {id: admin.id, admin: new_attributes}
			expect(response).to redirect_to(backoffice_admins_path)
		end

		it "with invalid params" do
			admin = create(:admin)
			put :update, params: {
				id: admin.id, admin: {
					email: nil
				}
			}
			expect(response).to render_template("edit")
		end
	end

	context "#destroy" do
		it "#destroy is deleted and redirect_to" do
				delete :destroy, params: {id: @admin.id}
				expect(response).to redirect_to(backoffice_admins_path)
				expect(controller).to set_flash[:notice]
		end
		it "#destroy is deleted to true" do
					expect{
					delete :destroy, params: {id: @admin.id}
				}.to change(Admin,:count).by(-1)
		end

	end
end
