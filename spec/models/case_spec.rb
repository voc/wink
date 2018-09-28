require 'rails_helper'

RSpec.describe Case, type: :model do

  before do

  end

  context "#locations" do
    it "should return case items from type ItemType::LOCATIONS" do
      c = Case.first

      expect(c.locations.count).to be > 0
    end
  end

  context "#check_list" do
    pending
  end

  context "#check_list_exists?" do
    pending
  end
end
