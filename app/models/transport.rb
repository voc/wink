class Transport < ActiveRecord::Base
  belongs_to :destination_event, class_name: "Event", foreign_key: "destination_event_id", optional: true
  belongs_to :source_event, class_name: "Event", foreign_key: "source_event_id", optional: true

  def tracking_url
    if self.carrier == 'K&N'
      return "https://onlineservices.kuehne-nagel.com/public-tracking/shipments/#{self.shipment_id}"
    end
  end

  def title
    from = self.source_event.nil? ? self.source_address : self.source_event.name
    to = self.destination_event.nil? ? self.destination_address : self.destination_event.name
    return "#{from} → #{to}"
  end

  alias name title
end
