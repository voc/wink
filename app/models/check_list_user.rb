class CheckListUser < ApplicationRecord
  belongs_to :check_list
  belongs_to :user

  validates_uniqueness_of :user_id, scope: :check_list_id
end
