require 'rails_helper'

RSpec.describe Backoffice::CategoriesController, type: :controller do

	before(:each) do |skip|
		session[:admin_id] = create(:admin).id
		unless skip.metadata[:skip_before]
			@category = create(:category)
		end
	end
  let(:valid_attributes) {
		{
			name: "Name of category",
      status: true,
      deleted: false,
      admin: session[:admin_id]
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
	      get :edit, params: {id: @category.id}
	      expect(response).to be_success
	    end
	  end
	end

	context "Post #create", :skip_before do
		it "#create new Category" do
			expect {
					post :create, params: {category: valid_attributes}
				}.to change(Category, :count).by(1)

		end

		it "redirects after create category" do
			post :create, params: {category: valid_attributes}
			expect(response).to redirect_to(backoffice_categories_path)
		end

		it "#create with invalid params" do
			post :create, params: {
				category: {
					name: nil
				}
			}
			expect(response).to render_template("new")
		end
	end

	context "PUT #update", :skip_before do
		name = Faker::Name.name
		let(:new_attributes) {
			{
					name: name
			}
		}

		it "updates the requested category" do
			category = create(:category)
			put :update, params: {id: category.id, category: new_attributes}
			category.reload
			expect(Category.last.name).to eq(name)
		end

		it "redirects to the category" do
			category = create(:category)
			put :update, params: {id: category.id, category: new_attributes}
			expect(response).to redirect_to(backoffice_categories_path)
		end

		it "with invalid params" do
			category = create(:category)
			put :update, params: {
				id: category.id, category: {
					name: nil
				}
			}
			expect(response).to render_template("edit")
		end
	end

	context "#destroy" do
		it "#destroy is deleted and redirect_to" do
				delete :destroy, params: {id: @category.id}
				expect(response).to redirect_to(backoffice_categories_path)
				expect(controller).to set_flash[:notice]
		end
		it "#destroy is deleted to true" do
					expect{
					delete :destroy, params: {id: @category.id}
				}.to change(Category,:count).by(-1)
		end

	end

end
