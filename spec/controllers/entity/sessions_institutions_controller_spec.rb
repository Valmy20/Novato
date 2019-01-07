require 'rails_helper'

RSpec.describe SessionsInstitutionsController, type: :controller do
  before(:each) do
    @institution = create(:institution)
  end
  context "when institution login" do
    it 'when create sesssion' do
      post :create, params: {login: {email: @institution.email, password: '123456'}}
      expect(request.session[:institution_id]).not_to be_nil
    end

    it 'when create fail' do
      post :create, params: {login: {email: @institution.email, password: '123452'}}
      expect(request.session[:institution_id]).to be_nil
    end

    it 'when create sesssion redirect_to' do
      post :create, params: {login: {email: @institution.email, password: '123456'}}
      expect(response).to redirect_to(entity_institution_profile_path)
    end
  end

  context "when institution destroy session" do
    it 'when destroy sesssion' do
      delete :destroy
      expect(request.session[:institution_id]).to be_nil
    end

    it 'when destroy sesssion redirect_to' do
      session[:institution_id] = @institution.id
      delete :destroy
      expect(response).to redirect_to(root_path)
    end
  end
end
