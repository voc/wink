class CheckListItem < ActiveRecord::Base
  belongs_to :check_list
  belongs_to :item
end
