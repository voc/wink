class CaseEvent < ActiveRecord::Base
  belongs_to :case
  belongs_to :event
  belongs_to :check_list
  belongs_to :transport
end
