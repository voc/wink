# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Case do
  describe "#locations" do
    it "returns case items from type ItemType::LOCATIONS" do
      c = described_class.first

      expect(c.locations.count).to be > 0
    end
  end

  describe "#check_list" do
    pending
  end

  describe "#check_list_exists?" do
    pending
  end
end
