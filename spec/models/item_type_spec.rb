# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ItemType do
  context "LOCATIONS" do
    it "is an array" do
      expect(ItemType::LOCATIONS).to be_a Array
    end

    it "is exist" do
      expect(ItemType::LOCATIONS).not_to be_nil
    end
  end
end
