require 'rails_helper'

RSpec.describe Item, type: :model do

  before do
    @case = Case.new(name: "möp", acronym: "bla")

    @item = Item.new(name: 'my item', model: 'foobar', case: @case)
    @item.item_type = ItemType.new(name: 'Fach')
  end

  context "#shelf? (virtual attribute)" do
    it "should return false if item_typ is not set" do
      item = Item.new(name: 'bla')
      expect(item.shelf?).to be false
    end

    it "should return true if item_typ is part of ItemType::LOCATIONS" do
      expect(@item.shelf?).to be true
    end
  end

  context "#name_with_model" do
    it "should return #name when model and manufacturer is not set" do
      item = Item.new(name: 'my item')

      expect(item.name_with_model).to eq "my item"
    end

    it "should return #name and #manufacturer when model is not set" do
      item = Item.new(name: 'my item', manufacturer: 'Intel')

      expect(item.name_with_model).to eq "my item (Intel)"
    end

    it "should return #name and #model when model is set" do
      expect(@item.name_with_model).to eq 'my item (foobar)'
    end
  end

  context "#md5_sum" do
    it "should return a String" do
      expect(@item.md5_sum).to be_a String
    end

    it "should return md5 sum" do
      expect(@item.md5_sum).to eq Digest::MD5.hexdigest(@item.to_json)
    end
  end

  context "#move_sub_items" do

    before do
      @new_case = Case.new(name: "new_case", acronym: "nc")
      @sub_item = Item.new(name: "sub_item", case: @case)

      @item.items << @sub_item
      @item.save
    end

    it "should move all subitems to the same case" do
      expect(@item.case).to eq @sub_item.case
      expect(@item.items.count).to eq 1

      @item.case = @new_case
      @item.save

      expect(@item.case).not_to eq @sub_item.case

      @item.move_sub_items
      expect(@item.case).to eq @sub_item.case
    end
  end

  context "#delete" do
    it "should not delete item" do
      item = Item.new(name: 'foobar')
      item.save
      item.delete

      expect(item.deleted).to be true
    end
  end

  context "#destroy" do
    it "should not delete item" do
      item = Item.new(name: 'foobar')
      item.save
      item.delete

      expect(item.deleted).to be true
    end
  end
end
