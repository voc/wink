class Item < ActiveRecord::Base
  has_many :item_comments
  has_many :items

  belongs_to :case
  belongs_to :item, optional: true
  belongs_to :item_type, optional: true
  belongs_to :location, optional: true, :class_name => "Item", :foreign_key => "location_item_id"

  validates :name, presence: true, uniqueness: { scope: [:case_id, :location_item_id, :item_id] }
  validates :case, presence: true

  scope :deleted, -> { where(deleted: true) }
  scope :not_deleted, -> { where(deleted: false) }
  scope :device, -> { where(item_type: ItemType.find_by(name: "Device")) }
  #       deleted = false AND ( broken = true OR missing = true )")
  scope :flagged, -> { where(broken: true).or(where(missing: true)).not_deleted }

  def name_with_model
    if self.model.nil? || self.model.empty?
      if self.manufacturer.nil? || self.manufacturer.empty?
        "#{name}"
      else
        "#{name} (#{manufacturer})"
      end
    else
      if self.manufacturer.nil? || self.manufacturer.empty? || self.manufacturer == '-'
        "#{name} (#{model})"
      else
        "#{name} (#{manufacturer} #{model})"
      end
    end
  end

  def shelf?
    return false if self.item_type.nil?

    if ItemType::LOCATIONS.include?(self.item_type.name)
      true
    else
      false
    end
  end

  def shelf_level
    return false if self.item_type.nil?
    ItemType::LOCATIONS.index { |x| self.item_type.name == x }
  end

  # Overwrite default functions.
  #
  # Items should be only disabled instead of deleted!
  def delete
    self.destroy
  end

  def destroy
    self.update_attribute(:deleted, true)
  end

  def is_deleted?
    self.read_attribute(:deleted)
  end

  def md5_sum
    Digest::MD5.hexdigest(self.to_json)
  end

  # Move all suitems to the same case.
  #
  # TODO: show message in view before save
  def move_sub_items
    self.items.each do |sub_item|
      if self.case != sub_item.case
        sub_item.case = self.case
        sub_item.location = nil
        sub_item.save!
      end
    end
  end

  def clone_item
    new_item = self.dup
    new_item.name = "#{self.name}"
    new_item.serial_number = ""
    new_item.items = []

    self.items.each do |sub_item|
      new_item.items << sub_item.clone_item
    end

    new_item.save
    new_item
  end


end
