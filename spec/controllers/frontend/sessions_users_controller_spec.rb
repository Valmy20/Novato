require 'rails_helper'

RSpec.describe SessionsUsersController, type: :controller do
  before(:each) do
    @user = create(:user)
  end
  context "when user login" do
    it 'when create sesssion' do
      post :create, params: {login: {email: @user.email, password: '123456'}}
      expect(request.session[:user_id]).not_to be_nil
    end

    it 'when create fail' do
      post :create, params: {login: {email: @user.email, password: '123452'}}
      expect(request.session[:user_id]).to be_nil
    end

    it 'when create sesssion redirect_to' do
      post :create, params: {login: {email: @user.email, password: '123456'}}
      expect(response).to redirect_to(frontend_user_path(@user))
    end
  end

  context "when user destroy session" do
    it 'when destroy sesssion' do
      delete :destroy
      expect(request.session[:user_id]).to be_nil
    end

    it 'when destroy sesssion redirect_to' do
      session[:user_id] = @user.id
      delete :destroy
      expect(response).to redirect_to(root_path)
    end
  end

  context "when login with provider facebook" do
    before(:each) do
      extend(OmniAuthTestHelper)
      valid_facebook_login_setup
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    end

    it "should redirect to frontend_user_path" do
      get :create, params: {provider: 'facebook'}
      expect(response).to redirect_to frontend_user_path(current_user)
    end

    it "facebook callback" do
      get :create, params: {provider: 'facebook'}
      expect(session[:user_id]).to eq(User.last.id)
    end
  end
end
