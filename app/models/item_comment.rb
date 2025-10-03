class ItemComment < ActiveRecord::Base
  has_one :item
  belongs_to :user, optional: true

  validate :author_or_user_present
  validates :item_id, presence: true
  validates :comment, presence: true

  default_scope { order(created_at: :desc) }

  def author_or_user
    if self.user.present?
      self.user.name || self.user.email
    else
      self.author
    end
  end

  def item
    Item.find(self.item_id)
  end

  def abstract
    self.comment[0..10]
  end

  private

  def author_or_user_present
    if self.user.nil? && self.author.blank?
      errors.add(:base, "Either user or author must be present")
    end
  end
end
