# frozen_string_literal: true

class Transport < ApplicationRecord
  belongs_to :destination_event, class_name: "Event", optional: true
  belongs_to :source_event, class_name: "Event", optional: true

  def tracking_url
    return unless carrier == "K&N"

      "https://onlineservices.kuehne-nagel.com/public-tracking/shipments/#{shipment_id}"
  end

  def title
    from = source_event.nil? ? source_address : source_event.name
    to = destination_event.nil? ? destination_address : destination_event.name
    "#{from} → #{to}"
  end

  alias name title
end
