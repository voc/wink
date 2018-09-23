class ItemComment < ActiveRecord::Base
  has_one :item

  validates :item_id, presence: true
  validates :author, presence: true
  validates :comment, presence: true

  default_scope { order(created_at: :desc) }

end
