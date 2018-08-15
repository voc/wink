class Item < ActiveRecord::Base
  has_many :item_comments
  belongs_to :case, optional: true

  belongs_to :item, optional: true
end
