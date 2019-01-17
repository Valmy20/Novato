require "rails_helper"

RSpec.describe Contributor::PostsController, type: :routing do

  describe "routing" do

		it "routes to #new" do
      expect(:get => contributor_posts_path).to route_to("contributor/posts#index")
    end

    it "routes to #new" do
      expect(:get => new_contributor_post_path).to route_to("contributor/posts#new")
    end

		it "routes to #create" do
      expect(:post => contributor_posts_path).to route_to("contributor/posts#create")
    end

		it "routes to #edit" do
      expect(:get => edit_contributor_post_path(1)).to route_to("contributor/posts#edit", id: '1')
    end

		it "routes to #update" do
      expect(:put => contributor_post_path(1)).to route_to("contributor/posts#update", id: '1')
    end

		it "routes to #detroy" do
      expect(:delete => contributor_post_path(1)).to route_to("contributor/posts#destroy", :id => '1')
    end

  end
end
