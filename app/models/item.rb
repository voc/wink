# frozen_string_literal: true

class Item < ApplicationRecord
  has_many :item_comments
  has_many :items

  belongs_to :case
  belongs_to :item, optional: true
  belongs_to :item_type, optional: true
  belongs_to :location, optional: true, class_name: "Item", foreign_key: "location_item_id"

  validates :name, presence: true

  def name_with_model
    if model.blank?
      if manufacturer.blank?
        name.to_s
      else
        "#{name} (#{manufacturer})"
      end
    elsif manufacturer.blank? || manufacturer == "-"
      "#{name} (#{model})"
    else
        "#{name} (#{manufacturer} #{model})"
    end
  end

  def shelf?
    return false if item_type.nil?

    ItemType::LOCATIONS.include?(item_type.name)
  end

  def shelf_level
    return false if item_type.nil?

    ItemType::LOCATIONS.index { |x| item_type.name == x }
  end

  # Overwrite default functions.
  #
  # Items should be only disabled instead of deleted!
  def delete
    destroy
  end

  def destroy
    update_attribute(:deleted, true)
  end

  def deleted?
    self[:deleted]
  end

  def md5_sum
    Digest::MD5.hexdigest(to_json)
  end

  # Move all suitems to the same case.
  #
  # TODO: show message in view before save
  def move_sub_items
    items.each do |sub_item|
      next unless self.case != sub_item.case

      sub_item.case = self.case
      sub_item.location = nil
      sub_item.save!
    end
  end

  def clone_item
    new_item = dup
    new_item.name = name.to_s
    new_item.serial_number = ""
    new_item.items = []

    items.each do |sub_item|
      new_item.items << sub_item.clone_item
    end

    new_item.save
    new_item
  end
end
