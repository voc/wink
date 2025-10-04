class User < ApplicationRecord
  has_many :check_list_users
  has_many :check_lists, through: :check_list_users

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }

  def to_s
    name || email || uid || id
  end
end
