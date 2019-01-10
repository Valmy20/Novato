require "rails_helper"

RSpec.describe Frontend::MessagesController, type: :routing do

  describe "routing" do

		it "routes to #new_message (get)" do
      expect(:get => new_message_path).to route_to("frontend/messages#new_message")
    end

		it "routes to #new_message (post)" do
      expect(:post => new_message_path).to route_to("frontend/messages#new_message")
    end

  end
end
