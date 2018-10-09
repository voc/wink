require "rails_helper"


RSpec.describe EventsController, :type => :controller do

  describe "GET index" do
    it "should return all events in json" do
      get :index, { format: :json }
      expect(response.content_type).to eq "application/json"
    end
  end

  describe "GET show" do
    it "should return event in json format" do
      get :show, { params: { id: 1 }, format: :json }
      expect(response.content_type).to eq "application/json"
    end
  end
end
