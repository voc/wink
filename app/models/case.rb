class Case < ActiveRecord::Base
  belongs_to :case_type

  has_many :events
  has_many :items
end
