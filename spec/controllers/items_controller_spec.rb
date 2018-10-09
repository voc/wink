require "rails_helper"


RSpec.describe ItemsController, :type => :controller do

  describe "GET index.json" do
    it "should return all items in json format" do
      get :index, { format: :json }
      expect(response.content_type).to eq "application/json"
    end
  end

  describe "GET show.json" do
    it "should return item in json format" do
      get :show, { params: { id: 1 },  format: :json }
      expect(response.content_type).to eq "application/json"
    end
  end
end
