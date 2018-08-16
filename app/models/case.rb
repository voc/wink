class Case < ActiveRecord::Base
  belongs_to :case_type

  has_many :events
  has_many :items

  validates :name, presence: true
  validates :acronym, presence: true
  validates :case_type, presence: true
end
