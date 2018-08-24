class ItemType < ActiveRecord::Base
  has_many :items


  LOCATIONS = ["Meshbag", "Fach"]
end
