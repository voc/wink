class ItemType < ActiveRecord::Base
  has_many :items

  validates :name, uniqueness: true, presence: true


  LOCATIONS = ["Fach", "Meshbag"]
end
