# frozen_string_literal: true

require "rails_helper"

RSpec.describe EventsController do
  describe "GET index" do
    it "returns all events in json" do
      get :index, { format: :json }
      expect(response.content_type).to eq "application/json"
    end
  end

  describe "GET show" do
    it "returns event in json format" do
      get :show, { params: { id: 1 }, format: :json }
      expect(response.content_type).to eq "application/json"
    end
  end
end
