# frozen_string_literal: true

class ItemComment < ApplicationRecord
  belongs_to :item

  validates :author, presence: true
  validates :comment, presence: true

  default_scope { order(created_at: :desc) }

  def item
    Item.find(item_id)
  end

  def abstract
    comment[0..10]
  end
end
