class EventCase < ActiveRecord::Base
  belongs_to :event
  belongs_to :case
  belongs_to :check_list, optional: true

  belongs_to :transport, optional: true
end
