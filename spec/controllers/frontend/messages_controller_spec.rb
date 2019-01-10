require 'rails_helper'

RSpec.describe Frontend::MessagesController, type: :controller do

  let(:valid_attributes) {
		{
			email: 'valmyericles@gmail.com',
			body: Faker::Lorem.paragraph,
		}
	}
	context "actions" do

	  describe "GET #new" do
	    it "returns http success" do
	      get :new_message
	      expect(response).to be_success
	    end
	  end

    context "Post #create", :skip_before do
      it "#create new Message" do
        expect {
            post :new_message, params: {message: valid_attributes}
          }.to change(Message, :count).by(1)

      end

      it "redirects after create message" do
        post :new_message, params: {message: valid_attributes}
        expect(response).to redirect_to(root_path)
      end

      it "#create with invalid params" do
        post :new_message, params: {
          message: {
            email: 'valmyericles@gmail.com',
            body: ''
          }
        }
        expect(response).to render_template(:new_message)
      end
    end

	end
end
