# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item do
  before do
    @case = Case.new(name: "möp", acronym: "bla")

    @item = described_class.new(name: 'my item', model: 'foobar', case: @case,
                                serial_number: "1337")
    @item.item_type = ItemType.new(name: 'Fach')
  end

  describe "#shelf? (virtual attribute)" do
    it "returns false if item_typ is not set" do
      item = described_class.new(name: 'bla')
      expect(item.shelf?).to be false
    end

    it "returns true if item_typ is part of ItemType::LOCATIONS" do
      expect(@item.shelf?).to be true
    end
  end

  describe "#name_with_model" do
    it "returns #name when model and manufacturer is not set" do
      item = described_class.new(name: 'my item')

      expect(item.name_with_model).to eq "my item"
    end

    it "returns #name and #manufacturer when model is not set" do
      item = described_class.new(name: 'my item', manufacturer: 'Intel')

      expect(item.name_with_model).to eq "my item (Intel)"
    end

    it "returns #name and #model when model is set" do
      expect(@item.name_with_model).to eq 'my item (foobar)'
    end
  end

  describe "#md5_sum" do
    it "returns a String" do
      expect(@item.md5_sum).to be_a String
    end

    it "returns md5 sum" do
      expect(@item.md5_sum).to eq Digest::MD5.hexdigest(@item.to_json)
    end
  end

  describe "#move_sub_items" do
    before do
      @new_case = Case.new(name: "new_case", acronym: "nc")
      @sub_item = described_class.new(name: "sub_item", case: @case)

      @item.items << @sub_item
      @item.save
    end

    it "moves all subitems to the same case" do
      expect(@item.case).to eq @sub_item.case
      expect(@item.items.count).to eq 1

      @item.case = @new_case
      @item.save

      expect(@item.case).not_to eq @sub_item.case

      @item.move_sub_items
      expect(@item.case).to eq @sub_item.case
    end
  end

  describe "#delete" do
    it "does not delete item" do
      item = described_class.new(name: 'foobar')
      item.save
      item.delete

      expect(item.deleted).to be true
    end
  end

  describe "#destroy" do
    it "does not delete item" do
      item = described_class.new(name: 'foobar')
      item.save
      item.delete

      expect(item.deleted).to be true
    end
  end

  describe "#clone_item" do
    it "clones item" do
      new_item = @item.clone_item

      expect(new_item).not_to eq @item
      expect(new_item.name).to eq "my item"
    end

    it "does not copy serialnumber" do
      new_item = @item.clone_item

      expect(new_item.serial_number).not_to eq @item.serial_number
      expect(new_item.serial_number).to eq ""
    end

    it "copies sub items" do
      item     = described_class.create(name: "my item")
      sub_item = described_class.create(name: "sub_item", case: @case)
      item.items << sub_item

      new_item = item.clone_item

      expect(new_item.items.count).to eq item.items.count
      expect(new_item.items.first.name).to eq "sub_item"
      expect(new_item).not_to eq item
    end

    it "returns new item clone" do
      new_item = @item.clone_item

      expect(new_item).not_to eq @item
      expect(new_item).not_to be_nil
    end
  end
end
