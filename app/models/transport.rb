class Transport < ActiveRecord::Base
  belongs_to :destination_event, class_name: "Event", foreign_key: "destination_event", optional: true
  belongs_to :source_event, class_name: "Event", foreign_key: "source_event", optional: true

  def tracking_url
    if self.carrier == 'K&N'
      return "https://onlineservices.kuehne-nagel.com/public-tracking/shipments/#{self.shipment_id}"
    end
  end
end
