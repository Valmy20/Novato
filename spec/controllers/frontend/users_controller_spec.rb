require 'rails_helper'

RSpec.describe Frontend::UsersController, type: :controller do

	before(:each) do |skip|
		session[:user_id] = create(:user).id
		unless skip.metadata[:skip_before]
			@user = create(:user)
		end
	end

  let(:valid_attributes) {
		{
			name: 'Valmy Ericles',
			email: 'valmyericles@gmail.com',
      password: '123456',
      password_confirmation: '123456',
			status: true
		}
	}
	context "actions" do
		it { is_expected.to use_before_action(:set_item) }

	  describe "GET #new" do
	    it "returns http success" do
	      get :new
	      expect(response).to be_success
	    end
	  end

	  describe "GET #edit" do
	    it "returns http success" do
	      get :edit, params: {id: @user.id}
	      expect(response).to be_success
	    end
	  end
	end

	context "#destroy" do
		it "#destroy is deleted and redirect_to" do
				delete :destroy, params: {id: @user.id}
				expect(response).to redirect_to(root_path)
				expect(controller).to set_flash[:notice]
		end
		it "#destroy is deleted to true" do
					expect{
					delete :destroy, params: {id: @user.id}
				}.to change(User,:count).by(-1)
		end

	end

end
