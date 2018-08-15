class Item < ActiveRecord::Base
  has_many :item_comments
  has_many :items

  belongs_to :case, optional: true
  belongs_to :item, optional: true
end
