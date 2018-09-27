require 'rails_helper'

RSpec.describe ItemType, type: :model do

  context "LOCATIONS" do
    it "should be an array" do
      expect(ItemType::LOCATIONS).to be_a Array
    end

    it "should be exist" do
      expect(ItemType::LOCATIONS).not_to be nil
    end
  end
end
