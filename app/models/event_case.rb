class EventCase < ActiveRecord::Base
  belongs_to :event
  belongs_to :case
  belongs_to :transport
end
