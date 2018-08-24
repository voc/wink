class CheckList < ActiveRecord::Base
  belongs_to :event
  belongs_to :case

  has_many :check_list_items
end
