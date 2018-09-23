class ItemComment < ActiveRecord::Base
  has_one :item

  validates :item_id, presence: true
  validates :author, presence: true
  validates :comment, presence: true

  default_scope { order(created_at: :desc) }


  def item
    Item.find(self.item_id)
  end

  def abstract
    self.comment[0..10]
  end
end
