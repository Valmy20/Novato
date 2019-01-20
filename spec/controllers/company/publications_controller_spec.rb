require 'rails_helper'

RSpec.describe Company::PublicationsController, type: :controller do

	before(:each) do |skip|
		session[:employer_id] = create(:employer).id
		unless skip.metadata[:skip_before]
			@publication = create(:publication)
		end
	end

  let(:valid_attributes) {
		{
			title: 'Vaga para analista de TI',
			_type: :estagio,
      information: Faker::Lorem.paragraph_by_chars([200, 260, 247, 450].sample, false),
      remunaration: 500,
			vacancies: [1,2,3].sample,
      publicationable_type: "Employer",
      publicationable_id: session[:employer_id]
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
	      get :edit, params: {id: @publication.id}
	      expect(response).to be_success
	    end
	  end
	end

  context "Post #create", :skip_before do
		it "#create new publication" do
			expect {
					post :create, params: {publication: valid_attributes}
				}.to change(Publication, :count).by(1)

		end

		it "redirects after create publication" do
			post :create, params: {publication: valid_attributes}
			expect(response).to redirect_to(company_publications_path)
		end

		it "#create with invalid params" do
			post :create, params: {
				publication: {
					name: '',
					information: ''
				}
			}
			expect(response).to render_template("new")
		end
	end

	context "#destroy" do
		it "#destroy is deleted and redirect_to" do
				delete :destroy, params: {id: @publication.id}
				expect(response).to redirect_to(company_publications_path)
				expect(controller).to set_flash[:notice]
		end
		it "#destroy is deleted to true" do
					expect{
					delete :destroy, params: {id: @publication.id}
				}.to change(Publication,:count).by(-1)
		end

	end

end
