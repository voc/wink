require "rails_helper"



RSpec.describe CheckListsController, type: :controller do
  before do
    sign_in_as_test_user
    @check_list = create(:check_list)
  end

  describe "GET index.json" do
    it "should return all checklists in json format" do
      get :index, as: :json
      expect(response).to have_http_status(:success)
      expect(response.media_type).to eq "application/json"
    end
  end

  describe "GET show.json" do
    it "should return checklist in json format" do
      get :show, params: { id: @check_list.id }, format: :json
      expect(response).to have_http_status(:success)
      expect(response.media_type).to eq "application/json"
    end
  end
end
