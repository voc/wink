class Transport < ActiveRecord::Base
  belongs_to :destination_event, class_name: "Event", foreign_key: "destination_event"
  belongs_to :source_event, class_name: "Event", foreign_key: "source_event"

  
end
