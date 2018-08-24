class CheckList < ActiveRecord::Base
  belongs_to :event_case

  has_many :check_list_items
end
