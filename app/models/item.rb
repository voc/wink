class Item < ActiveRecord::Base
  has_many :item_comments
  has_many :items

  belongs_to :case
  belongs_to :item, optional: true
  belongs_to :item_type, optional: true
  belongs_to :location, optional: true, :class_name => "Item", :foreign_key => "location_item_id"

  validates :name, presence: true
  validates :case, presence: true
end
