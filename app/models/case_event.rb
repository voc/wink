class CaseEvent < ActiveRecord::Base
  belongs_to :case
  belongs_to :event

end
