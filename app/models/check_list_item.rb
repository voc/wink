class CheckListItem < ActiveRecord::Base
  belongs_to :check_list
  belongs_to :item
  belongs_to :case
end
