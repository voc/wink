# frozen_string_literal: true

require "rails_helper"

RSpec.describe CasesController do
  describe "GET index.json" do
    it "returns all cases in json format" do
      get :index, { format: :json }
      expect(response.content_type).to eq "application/json"
    end
  end

  describe "GET show.json" do
    it "returns case in json format" do
      get :show, { params: { id: 1 },  format: :json }
      expect(response.content_type).to eq "application/json"
    end
  end
end
