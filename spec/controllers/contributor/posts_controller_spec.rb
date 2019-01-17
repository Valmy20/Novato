require 'rails_helper'

RSpec.describe Contributor::PostsController, type: :controller do

	before(:each) do |skip|
		session[:collaborator_id] = create(:collaborator).id
		unless skip.metadata[:skip_before]
			@post = create(:post)
		end
	end
  let(:valid_attributes) {
		{
			title: Faker::Lorem.name,
			body: Faker::Lorem.paragraph
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
	      get :edit, params: {id: @post.id}
	      expect(response).to be_success
	    end
	  end
	end

	context "Post #create", :skip_before do
		it "#create new Post" do
			expect {
					post :create, params: {post: valid_attributes}
				}.to change(Post, :count).by(1)

		end

		it "redirects after create post" do
			post :create, params: {post: valid_attributes}
			expect(response).to redirect_to(contributor_posts_path)
		end

		it "#create with invalid params" do
			post :create, params: {
				post: {
					title: nil,
					body: nil
				}
			}
			expect(response).to render_template("new")
		end
	end

	context "PUT #update", :skip_before do
		title = Faker::Lorem.name
		let(:new_attributes) {
			{
					title: title
			}
		}

		it "updates the requested post" do
			post = create(:post)
			put :update, params: {id: post.id, post: new_attributes}
			post.reload
			expect(Post.last.title).to eq(title)
		end

		it "redirects to the post" do
			post = create(:post)
			put :update, params: {id: post.id, post: new_attributes}
			expect(response).to redirect_to(contributor_posts_path)
		end

		it "with invalid params" do
			post = create(:post)
			put :update, params: {
				id: post.id, post: {
					title: nil
				}
			}
			expect(response).to render_template("edit")
		end
	end

	context "#destroy" do
		it "#destroy is deleted and redirect_to" do
				delete :destroy, params: {id: @post.id}
				expect(response).to redirect_to(contributor_posts_path)
				expect(controller).to set_flash[:notice]
		end
		it "#destroy is deleted to true" do
					expect{
					delete :destroy, params: {id: @post.id}
				}.to change(Post,:count).by(-1)
		end

	end
end
