class Case < ActiveRecord::Base
  belongs_to :case_type

  has_many :events
end
