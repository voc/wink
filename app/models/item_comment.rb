class ItemComment < ActiveRecord::Base
  belongs_to :item
  belongs_to :user, optional: true

  validate :author_or_user_present
  validates :item_id, presence: true
  validates :comment, presence: true

  default_scope { order(created_at: :desc) }

  before_validation :set_author, on: :create

  def item
    Item.find(self.item_id)
  end

  def abstract
    self.comment[0..10]
  end

  private

  def set_author
    if self.user.present? && self.author.blank?
      self.author = self.user.name || self.user.email
    end
  end

  def author_or_user_present
    if self.user.nil? && self.author.blank?
      errors.add(:base, "Either user or author must be present")
    end
  end
end
