# frozen_string_literal: true

require "rails_helper"

RSpec.describe ItemsController do
  describe "GET index.json" do
    it "returns all items in json format" do
      get :index, { format: :json }
      expect(response.content_type).to eq "application/json"
    end
  end

  describe "GET show.json" do
    it "returns item in json format" do
      get :show, { params: { id: 1 },  format: :json }
      expect(response.content_type).to eq "application/json"
    end
  end
end
