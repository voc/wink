require "rails_helper"



RSpec.describe CasesController, :type => :controller do
  before do
    sign_in_as_test_user
    @case = create(:case)
  end

  describe "GET index.json" do
    it "should return all cases in json format" do
      get :index, as: :json
      expect(response).to have_http_status(:success)
      expect(response.media_type).to eq "application/json"
    end
  end

  describe "GET show.json" do
    it "should return case in json format" do
      get :show, params: { id: @case.id }, format: :json
      expect(response).to have_http_status(:success)
      expect(response.media_type).to eq "application/json"
    end
  end
end
